import 'package:flutter/material.dart';

import '../../../../core/models/profile_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/link_utils.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    required this.profile,
    required this.onScrollToSection,
    super.key,
  });

  final ProfileModel profile;
  final void Function(String key) onScrollToSection;

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 980;
    final navItems = <String, String>{
      'about': 'About',
      'stack': 'Tech Stack',
      'experience': 'Experience',
      'projects': 'Projects',
      'education': 'Education',
      'achievements': 'Achievements',
      'contacts': 'Contact',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppPalette.surfaceAlt.withOpacity(0.85),
        border: Border(
          bottom: BorderSide(color: AppPalette.border.withOpacity(0.5)),
        ),
      ),
      child: isCompact
          ? Row(
              children: [
                Expanded(
                  child: Text(
                    profile.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => onScrollToSection('contacts'),
                  icon: const Icon(Icons.mail_outline),
                  tooltip: 'Contact',
                ),
              ],
            )
          : Row(
              children: [
                Text(
                  profile.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 24),
                ...navItems.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      onPressed: () => onScrollToSection(entry.key),
                      child: Text(entry.value),
                    ),
                  ),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () => launchExternalLink(profile.links.telegram),
                  icon: const Icon(Icons.send_outlined),
                  label: const Text('Telegram'),
                ),
                const SizedBox(width: 10),
                if (profile.links.hasCvEn)
                  FilledButton.icon(
                    onPressed: () => launchExternalLink(profile.links.cvDownloadEn),
                    icon: const Icon(Icons.download_outlined),
                    label: const Text('CV EN'),
                  ),
                if (profile.links.hasCvEn && profile.links.hasCvRu)
                  const SizedBox(width: 8),
                if (profile.links.hasCvRu)
                  FilledButton.tonalIcon(
                    onPressed: () => launchExternalLink(profile.links.cvDownloadRu),
                    icon: const Icon(Icons.download_outlined),
                    label: const Text('CV RU'),
                  ),
              ],
            ),
    );
  }
}
