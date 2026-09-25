import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Circular avatar with cached photo and initials fallback.
/// Role shells tint the ring with the role accent (Phase 3+).
class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.name,
    this.photoUrl,
    this.radius = AppSpacing.xl,
    this.ringColor,
  });

  final String name;
  final String? photoUrl;
  final double radius;
  final Color? ringColor;

  String get _initials {
    final List<String> parts =
        name.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    final Widget inner = photoUrl == null || photoUrl!.isEmpty
        ? CircleAvatar(
            radius: radius,
            backgroundColor: tokens.surfaceAlt,
            child: Text(
              _initials,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: tokens.ink),
            ),
          )
        : CachedNetworkImage(
            imageUrl: photoUrl!,
            imageBuilder: (_, image) => CircleAvatar(
              radius: radius,
              backgroundImage: image,
            ),
            placeholder: (_, _) => CircleAvatar(
              radius: radius,
              backgroundColor: tokens.surfaceAlt,
            ),
            errorWidget: (_, _, _) => CircleAvatar(
              radius: radius,
              backgroundColor: tokens.surfaceAlt,
              child: Text(_initials),
            ),
          );
    if (ringColor == null) return inner;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ringColor!, width: 2),
      ),
      child: inner,
    );
  }
}
