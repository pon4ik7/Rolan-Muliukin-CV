import 'package:flutter/material.dart';

import '../../../../core/models/achievement_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/link_utils.dart';
import 'glass_card.dart';
import 'section_title.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({required this.items, super.key});

  final List<AchievementModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Olympiads & Achievements',
          subtitle: 'Competitive Results',
        ),
        const SizedBox(height: 20),
        ...items.map(
          (item) => Padding(
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
                        colors: [AppPalette.primary, AppPalette.secondary],
                      ),
                    ),
                    child: const Icon(Icons.emoji_events_outlined),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.category} - ${item.result}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppPalette.secondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(item.description),
                      ],
                    ),
                  ),
                  if (item.link.isNotEmpty)
                    IconButton(
                      onPressed: () => launchExternalLink(item.link),
                      tooltip: 'Open certificate',
                      icon: const Icon(Icons.open_in_new),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
