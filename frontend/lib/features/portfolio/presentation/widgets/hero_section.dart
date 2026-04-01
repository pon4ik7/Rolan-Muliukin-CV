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
    final isCompact = MediaQuery.of(context).size.width < 900;
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

    return AnimatedReveal(
      child: Container(
        padding: EdgeInsets.fromLTRB(24, isCompact ? 24 : 44, 24, 34),
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
        child: Column(
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
            Text(
              displayName,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: isCompact ? 40 : 66,
                height: 0.98,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              role,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isCompact ? 23 : 31,
                color: AppPalette.accent,
              ),
            ),
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                headline,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 26),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: onProjectsTap,
                  icon: const Icon(Icons.coffee_outlined),
                  label: Text(i18n.viewProjects),
                ),
                OutlinedButton.icon(
                  onPressed: onContactTap,
                  icon: const Icon(Icons.mail_outline),
                  label: Text(i18n.contactMe),
                ),
                if (onDownloadCv != null)
                  OutlinedButton.icon(
                    onPressed: onDownloadCv,
                    icon: const Icon(Icons.download_outlined),
                    label: Text(i18n.downloadCvLabel(selectedCvLanguage)),
                  ),
                OutlinedButton.icon(
                  onPressed: () => launchExternalLink(profile.links.github),
                  icon: const Icon(Icons.code),
                  label: Text(i18n.github),
                ),
                OutlinedButton.icon(
                  onPressed: () => launchExternalLink(profile.links.leetcode),
                  icon: const Icon(Icons.bolt_outlined),
                  label: Text(i18n.leetcode),
                ),
                OutlinedButton.icon(
                  onPressed: () => launchExternalLink(profile.links.codeforces),
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
        ),
      ),
    );
  }
}
