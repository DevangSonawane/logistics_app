import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/models/hub.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/supervisor_providers.dart';

/// Manifest: destination hub, scanned summary, share PDF.
class ManifestPage extends ConsumerStatefulWidget {
  const ManifestPage({super.key, required this.items});

  final List<ScanItem> items;

  @override
  ConsumerState<ManifestPage> createState() => _ManifestPageState();
}

class _ManifestPageState extends ConsumerState<ManifestPage> {
  final TextEditingController _dest = TextEditingController(text: 'Chennai Hub');
  bool _working = false;
  Manifest? _saved;

  @override
  void dispose() {
    _dest.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_dest.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.fillAllFields)),
      );
      return;
    }
    setState(() => _working = true);
    try {
      final Manifest manifest = await ref
          .read(hubRepositoryProvider)
          .createManifest(_dest.text.trim(), widget.items);
      if (!mounted) return;
      setState(() {
        _working = false;
        _saved = manifest;
      });
      ref.invalidate(manifestsProvider);
    } catch (_) {
      if (!mounted) return;
      setState(() => _working = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commonError)),
      );
    }
  }

  Future<void> _share() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final Manifest? manifest = _saved;
    if (manifest == null) return;
    await ShareService().sharePdf(
      '${l10n.manifestTitle} ${manifest.id}',
      [
        (l10n.destHubLabel, manifest.destHub),
        (
          l10n.scannedLabel,
          '${manifest.items.length} / ${Formatters.dateTime(manifest.createdAt)}'
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final int damaged =
        widget.items.where((s) => s.damaged).length;
    final int shortage =
        widget.items.where((s) => s.shortage).length;
    return AppScaffold(
      title: l10n.manifestTitle,
      body: ListView(
        children: [
          AppTextField(
            controller: _dest,
            label: l10n.destHubLabel,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${l10n.scannedLabel}: ${widget.items.length}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text('${l10n.markDamage}: $damaged · ${l10n.markShortage}: $shortage'),
          const SizedBox(height: AppSpacing.xl),
          if (_saved == null)
            AppButton(
              label: l10n.createManifest,
              variant: AppButtonVariant.accent,
              large: true,
              loading: _working,
              onPressed: _working ? null : _create,
            )
          else
            AppButton(
              label: l10n.sharePdf,
              variant: AppButtonVariant.secondary,
              icon: Icons.share_outlined,
              onPressed: _share,
            ),
        ],
      ),
    );
  }
}
