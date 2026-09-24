import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/image_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/otp_input.dart';
import '../../../core/widgets/photo_capture_sheet.dart';
import '../../../data/mock/mock_users.dart';
import '../../../data/models/pod.dart';
import '../../../data/models/trip.dart';
import '../../auth/application/session_provider.dart';
import '../application/driver_trip_controller.dart';

/// D2. POD capture: signed-LR photo, consignee OTP (demo 4321) or
/// e-signature + name, optional damage/shortage. Queued on submit.
class PodCapturePage extends ConsumerStatefulWidget {
  const PodCapturePage({super.key, required this.trip});

  final Trip trip;

  @override
  ConsumerState<PodCapturePage> createState() => _PodCapturePageState();
}

class _PodCapturePageState extends ConsumerState<PodCapturePage> {
  String? _lrPhoto;
  PodMethod _method = PodMethod.otp;
  final TextEditingController _otp = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final SignatureController _signature = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black87,
    exportBackgroundColor: Colors.white,
  );
  bool _damage = false;
  final TextEditingController _remark = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final List<String> _damagePhotos = [];
  bool _working = false;
  bool _otpError = false;

  @override
  void dispose() {
    _otp.dispose();
    _name.dispose();
    _signature.dispose();
    _remark.dispose();
    _qty.dispose();
    super.dispose();
  }

  Future<void> _captureLr() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final PhotoSource? source = await PhotoCaptureSheet.show(
      context,
      cameraLabel: l10n.photoCamera,
      galleryLabel: l10n.photoGallery,
    );
    if (source == null || !mounted) return;
    final String? path = await ref.read(imageServiceProvider).capture(
      source: source,
      tag: '${widget.trip.id}_pod',
    );
    if (!mounted || path == null) return;
    setState(() => _lrPhoto = path);
  }

  Future<void> _addDamagePhoto() async {
    if (_damagePhotos.length >= 4) return;
    final AppLocalizations l10n = AppLocalizations.of(context);
    final PhotoSource? source = await PhotoCaptureSheet.show(
      context,
      cameraLabel: l10n.photoCamera,
      galleryLabel: l10n.photoGallery,
    );
    if (source == null || !mounted) return;
    final String? path = await ref.read(imageServiceProvider).capture(
      source: source,
      tag: '${widget.trip.id}_damage',
    );
    if (!mounted || path == null) return;
    setState(() => _damagePhotos.add(path));
  }

  Future<String?> _exportSignature() async {
    try {
      final bytes = await _signature.toPngBytes();
      if (bytes == null) return null;
      final Directory dir = await getApplicationDocumentsDirectory();
      final String path =
          '${dir.path}/sign_${widget.trip.id}_${DateTime.now().millisecondsSinceEpoch}.png';
      await File(path).writeAsBytes(bytes);
      return path;
    } catch (_) {
      return null;
    }
  }

  Future<void> _submit() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_lrPhoto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.photoRequired)),
      );
      return;
    }
    String? consigneeName;
    if (_method == PodMethod.otp) {
      if (_otp.text.trim() != MockUsers.podOtp) {
        setState(() => _otpError = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.podOtpWrong)),
        );
        return;
      }
    } else {
      if (_signature.isEmpty || _name.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.podSignHint)),
        );
        return;
      }
      consigneeName = _name.text.trim();
      await _exportSignature();
    }
    setState(() {
      _working = true;
      _otpError = false;
    });
    final String? driverId =
        ref.read(sessionProvider).user?.id;
    final PodSubmission pod = PodSubmission(
      tripId: widget.trip.id,
      lrPhotoPath: _lrPhoto!,
      method: _method,
      consigneeName: consigneeName,
      hasDamageOrShortage: _damage,
      damageRemark: _damage ? _remark.text.trim() : null,
      damageQty: _damage ? int.tryParse(_qty.text.trim()) : null,
      damagePhotos: List.of(_damagePhotos),
      submittedAt: DateTime.now(),
    );
    final MutationResult result = driverId == null
        ? (outcome: MutationOutcome.error, message: null)
        : await ref
            .read(driverTripProvider(driverId).notifier)
            .submitPod(pod);
    if (!mounted) return;
    setState(() => _working = false);
    switch (result.outcome) {
      case MutationOutcome.done:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.podDone)),
        );
        context.pop();
      case MutationOutcome.queued:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.stepQueued)),
        );
        context.pop();
      case MutationOutcome.conflict:
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.conflictTitle),
            content: Text(result.message ?? l10n.conflictMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.okAction),
              ),
            ],
          ),
        );
      case MutationOutcome.error:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.commonError)),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.podTitle,
      body: ListView(
        children: [
          _StepCard(
            title: l10n.podStep1,
            child: _lrPhoto == null
                ? AppButton(
                    label: l10n.photoCamera,
                    variant: AppButtonVariant.secondary,
                    icon: Icons.photo_camera_outlined,
                    onPressed: _captureLr,
                  )
                : Column(
                    children: [
                      ClipRRect(
                        borderRadius: AppSpacing.cardRadius,
                        child: Image.file(
                          File(_lrPhoto!),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 180,
                            color: context.tokens.surfaceAlt,
                            child: const Icon(Icons.receipt_long_outlined),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _captureLr,
                        child: Text(l10n.retryAction),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _StepCard(
            title: l10n.podStep2,
            child: Column(
              children: [
                SegmentedButton<PodMethod>(
                  segments: [
                    ButtonSegment(
                      value: PodMethod.otp,
                      label: Text(l10n.podOtpHint),
                    ),
                    ButtonSegment(
                      value: PodMethod.signature,
                      label: Text(l10n.podSignHint),
                    ),
                  ],
                  selected: {_method},
                  onSelectionChanged: (s) =>
                      setState(() => _method = s.first),
                ),
                const SizedBox(height: AppSpacing.md),
                if (_method == PodMethod.otp) ...[
                  OtpInput(
                    controller: _otp,
                    length: 4,
                    hasError: _otpError,
                    onCompleted: (_) => setState(() => _otpError = false),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.demoOtpHint,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: context.tokens.inkMuted,
                        ),
                  ),
                ] else ...[
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(color: context.tokens.border),
                      borderRadius: AppSpacing.inputRadius,
                      color: Colors.white,
                    ),
                    child: Signature(
                      controller: _signature,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => _signature.clear(),
                        child: Text(l10n.retryAction),
                      ),
                    ],
                  ),
                  AppTextField(
                    controller: _name,
                    label: l10n.podNameHint,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _StepCard(
            title: l10n.podDamageToggle,
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.podDamageToggle),
                  value: _damage,
                  onChanged: (v) => setState(() => _damage = v),
                ),
                if (_damage) ...[
                  AppTextField(
                    controller: _remark,
                    label: l10n.podDamageRemark,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _qty,
                    label: l10n.podDamageQty,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    children: [
                      for (final path in _damagePhotos)
                        ClipRRect(
                          borderRadius: AppSpacing.inputRadius,
                          child: Image.file(
                            File(path),
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 72,
                              height: 72,
                              color: context.tokens.surfaceAlt,
                              child: const Icon(Icons.broken_image_outlined),
                            ),
                          ),
                        ),
                      if (_damagePhotos.length < 4)
                        GestureDetector(
                          onTap: _addDamagePhoto,
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.tokens.border,
                              ),
                              borderRadius: AppSpacing.inputRadius,
                            ),
                            child: const Icon(Icons.add_a_photo_outlined),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: l10n.podSubmit,
            variant: AppButtonVariant.accent,
            large: true,
            loading: _working,
            onPressed: _working ? null : _submit,
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}
