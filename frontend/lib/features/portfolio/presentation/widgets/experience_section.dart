import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/models/experience_model.dart';
import '../../../../core/theme/app_theme.dart';
import 'glass_card.dart';
import 'section_title.dart';
import 'skill_chip.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({required this.items, required this.i18n, super.key});

  final List<ExperienceModel> items;
  final AppLocalization i18n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: i18n.experienceTitle,
          subtitle: i18n.experienceSubtitle,
        ),
        const SizedBox(height: 20),
        ...items.map(
          (item) {
            final title = i18n.isRussian && item.titleRu.isNotEmpty
                ? item.titleRu
                : item.title;
            final organization =
                i18n.isRussian && item.organizationRu.isNotEmpty
                ? item.organizationRu
                : item.organization;
            final description =
                i18n.isRussian && item.descriptionRu.isNotEmpty
                ? item.descriptionRu
                : item.description;
            final period = i18n.isRussian && item.periodRu.isNotEmpty
                ? item.periodRu
                : item.period;
            final highlights =
                i18n.isRussian && item.highlightsRu.isNotEmpty
                ? item.highlightsRu
                : item.highlights;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(top: 6, right: 10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppPalette.primary,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                organization,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppPalette.secondary),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          period,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppPalette.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(description),
                    const SizedBox(height: 12),
                    ...highlights.map(
                      (point) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 7, right: 8),
                              child: Icon(
                                Icons.circle,
                                size: 7,
                                color: AppPalette.secondary,
                              ),
                            ),
                            Expanded(child: Text(point)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: item.techStack
                          .map((skill) => SkillChip(label: skill))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
