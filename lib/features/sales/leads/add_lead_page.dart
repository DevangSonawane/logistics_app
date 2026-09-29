import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/image_service.dart';
import '../../../core/services/voice_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_filter_chip.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/photo_capture_sheet.dart';
import '../../../data/models/lead.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/sales_providers.dart';

/// S2. Add lead: duplicate detection, voice note with mock transcription,
/// business card scan with mock OCR prefill.
class AddLeadPage extends ConsumerStatefulWidget {
  const AddLeadPage({super.key});

  @override
  ConsumerState<AddLeadPage> createState() => _AddLeadPageState();
}

class _AddLeadPageState extends ConsumerState<AddLeadPage> {
  final TextEditingController _company = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _from = TextEditingController();
  final TextEditingController _to = TextEditingController();
  final TextEditingController _trips = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  LeadSource _source = LeadSource.website;
  String _vehicle = '32 ft MXL';
  bool _duplicate = false;
  bool _recording = false;
  bool _working = false;
  String? _error;

  @override
  void dispose() {
    _company.dispose();
    _contact.dispose();
    _phone.dispose();
    _from.dispose();
    _to.dispose();
    _trips.dispose();
    _rate.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _checkDuplicate() async {
    final String phone = _phone.text.trim();
    if (phone.isEmpty) {
      setState(() => _duplicate = false);
      return;
    }
    final List<Lead> leads =
        await ref.read(leadRepositoryProvider).leads();
    if (!mounted) return;
    setState(
      () => _duplicate = leads.any((l) => l.phone == phone),
    );
  }

  Future<void> _voiceNote() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final VoiceService voice = ref.read(voiceServiceProvider);
    if (_recording) {
      await voice.stopNote();
      if (!mounted) return;
      setState(() {
        _recording = false;
        // Mock transcription fills the notes field.
        _notes.text = '${_notes.text} [${l10n.voiceTranscribed}]'.trim();
      });
      return;
    }
    final String? path = await voice.startNote();
    if (!mounted) return;
    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.voiceNotAvailable)),
      );
      return;
    }
    setState(() => _recording = true);
  }

  Future<void> _scanCard() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final PhotoSource? source = await PhotoCaptureSheet.show(
      context,
      cameraLabel: l10n.photoCamera,
      galleryLabel: l10n.photoGallery,
    );
    if (source == null || !mounted) return;
    final String? path = await ref
        .read(imageServiceProvider)
        .capture(source: source, tag: 'bizcard');
    if (!mounted || path == null) return;
    // Mock OCR prefill.
    setState(() {
      _company.text = 'Scanned Traders Co';
      _contact.text = 'Card Contact';
      _phone.text = '9810098100';
    });
    _checkDuplicate();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.cardScanned)),
    );
  }

  String _sourceLabel(AppLocalizations l10n, LeadSource source) {
    return switch (source) {
      LeadSource.website => l10n.srcWebsite,
      LeadSource.whatsapp => l10n.srcWhatsapp,
      LeadSource.indiamart => l10n.srcIndiamart,
      LeadSource.justdial => l10n.srcJustdial,
      LeadSource.ivr => l10n.srcIvr,
      LeadSource.email => l10n.srcEmail,
      LeadSource.walkin => l10n.srcWalkin,
      LeadSource.referral => l10n.srcReferral,
    };
  }

  Future<void> _save() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_company.text.trim().isEmpty ||
        !Validators.isPhoneValid(_phone.text.trim()) ||
        _from.text.trim().isEmpty ||
        _to.text.trim().isEmpty) {
      setState(() => _error = l10n.fillAllFields);
      return;
    }
    setState(() {
      _error = null;
      _working = true;
    });
    try {
      await ref.read(leadRepositoryProvider).add(
            Lead(
              id: 'local',
              company: _company.text.trim(),
              contact: _contact.text.trim().isEmpty
                  ? _company.text.trim()
                  : _contact.text.trim(),
              phone: _phone.text.trim(),
              source: _source,
              from: _from.text.trim(),
              to: _to.text.trim(),
              vehicleType: _vehicle,
              expectedTrips:
                  int.tryParse(_trips.text.trim()) ?? 0,
              targetRate: int.tryParse(_rate.text.trim()) ?? 0,
              notes: _notes.text.trim().isEmpty
                  ? null
                  : _notes.text.trim(),
            ),
          );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _working = false;
        _error = l10n.commonError;
      });
      return;
    }
    ref.invalidate(salesLeadsProvider);
    if (!mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    return AppScaffold(
      title: l10n.addLeadTitle,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _QuickTile(
                        icon: _recording
                            ? Icons.stop_outlined
                            : Icons.mic_none_outlined,
                        label: _recording
                            ? l10n.listeningLabel
                            : l10n.voiceNoteAction,
                        tint: _recording
                            ? AppColors.danger
                            : tokens.primary,
                        onTap: _voiceNote,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _QuickTile(
                        icon: Icons.contact_page_outlined,
                        label: l10n.scanCardAction,
                        tint: tokens.primary,
                        onTap: _scanCard,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                _FormSection(
                  title: l10n.companyLabel,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _company,
                        label: l10n.companyLabel,
                        prefixIcon: Icons.business_outlined,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        controller: _contact,
                        label: l10n.contactLabel,
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        controller: _phone,
                        label: l10n.phoneLabel,
                        keyboardType: TextInputType.phone,
                        phonePrefix: true,
                        prefixIcon: Icons.phone_outlined,
                        onChanged: (_) => _checkDuplicate(),
                      ),
                      if (_duplicate) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            const Icon(
                              Icons.warning_amber_outlined,
                              size: 14,
                              color: AppColors.warning,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                l10n.duplicateLead,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.warning,
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _FormSection(
                  title: l10n.sourceLabel,
                  child: Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final LeadSource s
                          in LeadSource.values)
                        AppFilterChip(
                          label: _sourceLabel(l10n, s),
                          selected: _source == s,
                          onTap: () =>
                              setState(() => _source = s),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _FormSection(
                  title: l10n.stepRoute,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: _from,
                              label: l10n.fromLabel,
                              prefixIcon: Icons.trip_origin,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: AppTextField(
                              controller: _to,
                              label: l10n.toLabel,
                              prefixIcon:
                                  Icons.place_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      DropdownButtonFormField<String>(
                        initialValue: _vehicle,
                        decoration: InputDecoration(
                          labelText: l10n.vehicleTypeLabel,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: '32 ft MXL',
                            child: Text('32 ft MXL'),
                          ),
                          DropdownMenuItem(
                            value: '20 ft',
                            child: Text('20 ft'),
                          ),
                          DropdownMenuItem(
                            value: 'Tata Ace',
                            child: Text('Tata Ace'),
                          ),
                          DropdownMenuItem(
                            value: 'Container',
                            child: Text('Container'),
                          ),
                        ],
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _vehicle = v);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _FormSection(
                  title: l10n.tripsPerMonth,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: _trips,
                              label: l10n.tripsPerMonth,
                              keyboardType:
                                  TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: AppTextField(
                              controller: _rate,
                              label: l10n.targetRateLabel,
                              keyboardType:
                                  TextInputType.number,
                              prefixIcon: Icons
                                  .currency_rupee_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        controller: _notes,
                        label: l10n.notesLabel,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 16,
                        color: AppColors.danger,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          _error!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: AppColors.danger,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SafeArea(
            top: false,
            child: AppButton(
              label: l10n.saveLeadAction,
              loading: _working,
              onPressed: _working ? null : _save,
            ),
          ),
        ],
      ),
    );
  }
}

/// Tinted quick-action tile (voice note / card scan).
class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.icon,
    required this.label,
    required this.tint,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color tint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.08),
          borderRadius: AppSpacing.cardRadius,
          border: Border.all(color: tint.withValues(alpha: 0.25)),
        ),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tint,
              ),
              child: Icon(icon, size: 18, color: Colors.white),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: tint,
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Card grouping one form section with a semibold title.
class _FormSection extends StatelessWidget {
  const _FormSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(color: context.tokens.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}
