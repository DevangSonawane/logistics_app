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
    final AppColorTokens tokens = context.tokens;
    return AppScaffold(
      title: l10n.podTitle,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: tokens.primary.withValues(alpha: 0.08),
                    borderRadius: AppSpacing.cardRadius,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_shipping_outlined,
                        size: 18,
                        color: tokens.primary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          '${widget.trip.no} · ${widget.trip.customer}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: tokens.primary,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _StepCard(
                  index: 1,
                  title: l10n.podStep1,
                  done: _lrPhoto != null,
                  child: _lrPhoto == null
                      ? GestureDetector(
                          onTap: _captureLr,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: tokens.primary
                                  .withValues(alpha: 0.06),
                              borderRadius:
                                  AppSpacing.inputRadius,
                              border: Border.all(
                                color: tokens.primary.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 28,
                                  color: tokens.primary,
                                ),
                                const SizedBox(
                                  height: AppSpacing.xs,
                                ),
                                Text(
                                  l10n.photoCamera,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: tokens.primary,
                                        fontWeight:
                                            FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  AppSpacing.inputRadius,
                              child: Image.file(
                                File(_lrPhoto!),
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) =>
                                    Container(
                                  height: 160,
                                  color: tokens.surfaceAlt,
                                  child: const Icon(
                                    Icons.receipt_long_outlined,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: _captureLr,
                              child:
                                  Text(l10n.photoRetake),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: AppSpacing.md),
                _StepCard(
                  index: 2,
                  title: l10n.podStep2,
                  done: _method == PodMethod.otp
                      ? _otp.text.trim().length == 4
                      : _signature.isNotEmpty &&
                          _name.text.trim().isNotEmpty,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _MethodPill(
                        label: l10n.podOtpHint,
                        icon: Icons.sms_outlined,
                        selected: _method == PodMethod.otp,
                        onTap: () => setState(
                          () => _method = PodMethod.otp,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _MethodPill(
                        label: l10n.podSignHint,
                        icon: Icons.draw_outlined,
                        selected:
                            _method == PodMethod.signature,
                        onTap: () => setState(
                          () => _method = PodMethod.signature,
                        ),
                      ),
                    ),
                  ],
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
          const SizedBox(height: AppSpacing.md),
          _StepCard(
            index: 3,
            title: l10n.podDamageToggle,
            done: false,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.podDamageToggle,
                        style:
                            Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Switch(
                      value: _damage,
                      onChanged: (v) =>
                          setState(() => _damage = v),
                    ),
                  ],
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
                            errorBuilder: (_, _, _) => Container(
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
          ],
        ),
      ),
          const SizedBox(height: AppSpacing.md),
          SafeArea(
            top: false,
            child: AppButton(
              label: l10n.podSubmit,
              loading: _working,
              onPressed: _working ? null : _submit,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.index,
    required this.title,
    required this.done,
    required this.child,
  });

  final int index;
  final String title;
  final bool done;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(
          color: done ? AppColors.success : tokens.border,
          width: done ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: done
                      ? AppColors.success
                      : tokens.primary.withValues(alpha: 0.12),
                ),
                child: done
                    ? const Icon(
                        Icons.check_outlined,
                        size: 16,
                        color: Colors.white,
                      )
                    : Text(
                        '$index',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color: tokens.primary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 15),
              ),
            ),
          ],
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}

/// Side-by-side confirm-method pill (OTP / signature).
class _MethodPill extends StatelessWidget {
  const _MethodPill({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppSpacing.motionFast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? tokens.primary
              : tokens.primary.withValues(alpha: 0.07),
          borderRadius: AppSpacing.cardRadius,
          border: Border.all(
            color: selected
                ? tokens.primary
                : tokens.primary.withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color:
                  selected ? tokens.onPrimary : tokens.primary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                label,
                style:
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: selected
                              ? tokens.onPrimary
                              : tokens.primary,
                        ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
