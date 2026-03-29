import 'package:flutter/material.dart';

import '../../../../core/models/profile_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/link_utils.dart';
import 'animated_reveal.dart';
import 'skill_chip.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    required this.profile,
    required this.onProjectsTap,
    required this.onContactTap,
    super.key,
  });

  final ProfileModel profile;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 900;

    return AnimatedReveal(
      child: Container(
        padding: EdgeInsets.fromLTRB(24, isCompact ? 20 : 42, 24, 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF152749), Color(0xFF0C1530), Color(0xFF0A1126)],
          ),
          border: Border.all(color: AppPalette.border.withOpacity(0.7)),
          boxShadow: [
            BoxShadow(
              color: AppPalette.primary.withOpacity(0.2),
              blurRadius: 40,
              spreadRadius: 2,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppPalette.success.withOpacity(0.15),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppPalette.success.withOpacity(0.5)),
              ),
              child: Text(
                profile.availabilityBadge,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppPalette.success,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              profile.name,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: isCompact ? 42 : 62,
                height: 1,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              profile.role,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isCompact ? 24 : 30,
                color: AppPalette.secondary,
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                profile.headline,
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
                  icon: const Icon(Icons.rocket_launch_outlined),
                  label: const Text('View Projects'),
                ),
                OutlinedButton.icon(
                  onPressed: onContactTap,
                  icon: const Icon(Icons.mail_outline),
                  label: const Text('Contact Me'),
                ),
                if (profile.links.hasCvEn)
                  OutlinedButton.icon(
                    onPressed: () => launchExternalLink(profile.links.cvDownloadEn),
                    icon: const Icon(Icons.download_outlined),
                    label: const Text('Download CV (EN)'),
                  ),
                if (profile.links.hasCvRu)
                  OutlinedButton.icon(
                    onPressed: () => launchExternalLink(profile.links.cvDownloadRu),
                    icon: const Icon(Icons.download_outlined),
                    label: const Text('Download CV (RU)'),
                  ),
                TextButton.icon(
                  onPressed: () => launchExternalLink(profile.links.github),
                  icon: const Icon(Icons.code),
                  label: const Text('GitHub'),
                ),
                TextButton.icon(
                  onPressed: () => launchExternalLink(profile.links.leetcode),
                  icon: const Icon(Icons.bolt_outlined),
                  label: const Text('LeetCode'),
                ),
                TextButton.icon(
                  onPressed: () => launchExternalLink(profile.links.codeforces),
                  icon: const Icon(Icons.leaderboard_outlined),
                  label: const Text('Codeforces'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: profile.primaryStack.map((item) => SkillChip(label: item)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
