import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/models/achievement_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/link_utils.dart';
import 'glass_card.dart';
import 'section_title.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({
    required this.items,
    required this.i18n,
    super.key,
  });

  final List<AchievementModel> items;
  final AppLocalization i18n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: i18n.achievementsTitle,
          subtitle: i18n.achievementsSubtitle,
        ),
        const SizedBox(height: 20),
        ...items.map((item) {
          final title = i18n.isRussian && item.titleRu.isNotEmpty
              ? item.titleRu
              : item.title;
          final category = i18n.isRussian && item.categoryRu.isNotEmpty
              ? item.categoryRu
              : item.category;
          final result = i18n.isRussian && item.resultRu.isNotEmpty
              ? item.resultRu
              : item.result;
          final description = i18n.isRussian && item.descriptionRu.isNotEmpty
              ? item.descriptionRu
              : item.description;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlassCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [AppPalette.primary, AppPalette.accent],
                      ),
                    ),
                    child: const Icon(
                      Icons.emoji_events_outlined,
                      color: AppPalette.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$category - $result',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppPalette.accent),
                        ),
                        const SizedBox(height: 8),
                        Text(description),
                      ],
                    ),
                  ),
                  if (item.link.isNotEmpty)
                    IconButton(
                      onPressed: () => launchExternalLink(item.link),
                      tooltip: i18n.openCertificate,
                      icon: const Icon(Icons.open_in_new),
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
