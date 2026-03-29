import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/link_utils.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    required this.profile,
    required this.i18n,
    required this.cvLanguage,
    required this.onToggleLanguage,
    required this.onDownloadCv,
    required this.onScrollToSection,
    super.key,
  });

  final ProfileModel profile;
  final AppLocalization i18n;
  final AppLanguage cvLanguage;
  final VoidCallback onToggleLanguage;
  final VoidCallback? onDownloadCv;
  final void Function(String key) onScrollToSection;

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 980;
    final navItems = i18n.navItems;

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
                  tooltip: i18n.contactTooltip,
                ),
                if (onDownloadCv != null)
                  IconButton(
                    onPressed: onDownloadCv,
                    icon: const Icon(Icons.download_outlined),
                    tooltip: i18n.downloadCvLabel(cvLanguage),
                  ),
                Tooltip(
                  message: i18n.switchLanguageTooltip,
                  child: OutlinedButton.icon(
                    onPressed: onToggleLanguage,
                    icon: const Icon(Icons.language_outlined, size: 18),
                    label: Text(i18n.switchLanguageButton),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
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
                Tooltip(
                  message: i18n.switchLanguageTooltip,
                  child: OutlinedButton.icon(
                    onPressed: onToggleLanguage,
                    icon: const Icon(Icons.language_outlined),
                    label: Text(i18n.switchLanguageButton),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: () => launchExternalLink(profile.links.telegram),
                  icon: const Icon(Icons.send_outlined),
                  label: Text(i18n.telegram),
                ),
                const SizedBox(width: 10),
                if (onDownloadCv != null)
                  FilledButton.tonalIcon(
                    onPressed: onDownloadCv,
                    icon: const Icon(Icons.download_outlined),
                    label: Text(i18n.cvButtonLabel(cvLanguage)),
                  ),
              ],
            ),
    );
  }
}
