import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/link_utils.dart';
import 'animated_reveal.dart';
import 'skill_chip.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    required this.profile,
    required this.i18n,
    required this.selectedCvLanguage,
    required this.onDownloadCv,
    required this.onProjectsTap,
    required this.onContactTap,
    super.key,
  });

  final ProfileModel profile;
  final AppLocalization i18n;
  final AppLanguage selectedCvLanguage;
  final VoidCallback? onDownloadCv;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 980;
    final availabilityBadge =
        i18n.isRussian && profile.availabilityBadgeRu.isNotEmpty
        ? profile.availabilityBadgeRu
        : profile.availabilityBadge;
    final displayName = i18n.isRussian && profile.nameRu.isNotEmpty
        ? profile.nameRu
        : profile.name;
    final role = i18n.isRussian && profile.roleRu.isNotEmpty
        ? profile.roleRu
        : profile.role;
    final headline = i18n.isRussian && profile.headlineRu.isNotEmpty
        ? profile.headlineRu
        : profile.headline;
    final profilePhotoUrl = Uri.base
        .resolve('images/profile-photo.jpg')
        .toString();

    return AnimatedReveal(
      child: Container(
        constraints: BoxConstraints(minHeight: isCompact ? 0 : 430),
        padding: EdgeInsets.fromLTRB(24, isCompact ? 24 : 36, 24, 34),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppPalette.surface,
              AppPalette.secondary.withOpacity(0.88),
              AppPalette.surfaceAlt,
            ],
          ),
          border: Border.all(color: AppPalette.border),
          boxShadow: [
            BoxShadow(
              color: AppPalette.primary.withOpacity(0.1),
              blurRadius: 36,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: isCompact
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroBody(
                    availabilityBadge: availabilityBadge,
                    displayName: displayName,
                    role: role,
                    headline: headline,
                    i18n: i18n,
                    profile: profile,
                    selectedCvLanguage: selectedCvLanguage,
                    onDownloadCv: onDownloadCv,
                    onProjectsTap: onProjectsTap,
                    onContactTap: onContactTap,
                    compact: true,
                    photoUrl: profilePhotoUrl,
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _HeroBody(
                      availabilityBadge: availabilityBadge,
                      displayName: displayName,
                      role: role,
                      headline: headline,
                      i18n: i18n,
                      profile: profile,
                      selectedCvLanguage: selectedCvLanguage,
                      onDownloadCv: onDownloadCv,
                      onProjectsTap: onProjectsTap,
                      onContactTap: onContactTap,
                      compact: false,
                      photoUrl: profilePhotoUrl,
                    ),
                  ),
                  const SizedBox(width: 26),
                  _ProfilePhoto(photoUrl: profilePhotoUrl),
                ],
              ),
      ),
    );
  }
}

class _HeroBody extends StatelessWidget {
  const _HeroBody({
    required this.availabilityBadge,
    required this.displayName,
    required this.role,
    required this.headline,
    required this.i18n,
    required this.profile,
    required this.selectedCvLanguage,
    required this.onDownloadCv,
    required this.onProjectsTap,
    required this.onContactTap,
    required this.compact,
    required this.photoUrl,
  });

  final String availabilityBadge;
  final String displayName;
  final String role;
  final String headline;
  final AppLocalization i18n;
  final ProfileModel profile;
  final AppLanguage selectedCvLanguage;
  final VoidCallback? onDownloadCv;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;
  final bool compact;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: AppPalette.success.withOpacity(0.12),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppPalette.success.withOpacity(0.45)),
          ),
          child: Text(
            availabilityBadge,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppPalette.success,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 24),
        if (compact)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _InlineAvatar(photoUrl: photoUrl),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  displayName,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 38,
                    height: 0.98,
                  ),
                ),
              ),
            ],
          )
        else
          Text(
            displayName,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontSize: 60, height: 0.98),
          ),
        const SizedBox(height: 8),
        Text(
          role,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: compact ? 23 : 30,
            color: AppPalette.accent,
          ),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Text(
            headline,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppPalette.textSecondary),
          ),
        ),
        const SizedBox(height: 26),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              onPressed: onProjectsTap,
              style: FilledButton.styleFrom(minimumSize: const Size(172, 46)),
              icon: const Icon(Icons.coffee_outlined),
              label: Text(i18n.viewProjects),
            ),
            OutlinedButton.icon(
              onPressed: onContactTap,
              style: OutlinedButton.styleFrom(minimumSize: const Size(164, 46)),
              icon: const Icon(Icons.mail_outline),
              label: Text(i18n.contactMe),
            ),
            if (onDownloadCv != null)
              OutlinedButton.icon(
                onPressed: onDownloadCv,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(186, 46),
                ),
                icon: const Icon(Icons.download_outlined),
                label: Text(i18n.downloadCvLabel(selectedCvLanguage)),
              ),
            OutlinedButton.icon(
              onPressed: () => launchExternalLink(profile.links.github),
              style: OutlinedButton.styleFrom(minimumSize: const Size(132, 46)),
              icon: const Icon(Icons.code),
              label: Text(i18n.github),
            ),
            OutlinedButton.icon(
              onPressed: () => launchExternalLink(profile.links.leetcode),
              style: OutlinedButton.styleFrom(minimumSize: const Size(132, 46)),
              icon: const Icon(Icons.bolt_outlined),
              label: Text(i18n.leetcode),
            ),
            OutlinedButton.icon(
              onPressed: () => launchExternalLink(profile.links.codeforces),
              style: OutlinedButton.styleFrom(minimumSize: const Size(152, 46)),
              icon: const Icon(Icons.leaderboard_outlined),
              label: Text(i18n.codeforces),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: profile.primaryStack
              .map((item) => SkillChip(label: item))
              .toList(),
        ),
      ],
    );
  }
}

class _InlineAvatar extends StatelessWidget {
  const _InlineAvatar({required this.photoUrl});

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppPalette.border),
        color: AppPalette.surface,
      ),
      child: ClipOval(
        child: Image.network(
          photoUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppPalette.surfaceAlt,
              child: const Icon(Icons.person, color: AppPalette.accent),
            );
          },
        ),
      ),
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto({required this.photoUrl, this.compact = false});

  final String photoUrl;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final width = compact ? 210.0 : 300.0;
    final height = compact ? 260.0 : 360.0;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppPalette.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppPalette.border),
        boxShadow: [
          BoxShadow(
            color: AppPalette.primary.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          photoUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _PhotoFallback(
            compact: compact,
            hintPath: 'frontend/web/images/profile-photo.jpg',
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          },
        ),
      ),
    );
  }
}

class _PhotoFallback extends StatelessWidget {
  const _PhotoFallback({required this.compact, required this.hintPath});

  final bool compact;
  final String hintPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPalette.surfaceAlt,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_outline, size: 54, color: AppPalette.accent),
          const SizedBox(height: 10),
          Text(
            'Добавьте фото',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SelectableText(
            hintPath,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppPalette.textSecondary),
          ),
          if (!compact) ...[
            const SizedBox(height: 8),
            Text(
              'Файл: profile-photo.jpg',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppPalette.textSecondary),
            ),
          ],
        ],
      ),
    );
  }
}
