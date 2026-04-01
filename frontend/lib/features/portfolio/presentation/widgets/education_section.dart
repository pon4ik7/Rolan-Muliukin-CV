import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../core/theme/app_theme.dart';
import 'glass_card.dart';
import 'section_title.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({
    required this.profile,
    required this.i18n,
    super.key,
  });

  final ProfileModel profile;
  final AppLocalization i18n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: i18n.educationTitle,
          subtitle: i18n.educationSubtitle,
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final twoColumns = constraints.maxWidth >= 980;
            final cardWidth = twoColumns
                ? (constraints.maxWidth - 16) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ...profile.education.map((item) {
                  final title = i18n.isRussian && item.institutionRu.isNotEmpty
                      ? item.institutionRu
                      : item.institution;
                  final subtitle = i18n.isRussian && item.programRu.isNotEmpty
                      ? item.programRu
                      : item.program;
                  final details = i18n.isRussian && item.detailsRu.isNotEmpty
                      ? item.detailsRu
                      : item.details;
                  final period = i18n.isRussian && item.periodRu.isNotEmpty
                      ? item.periodRu
                      : item.period;

                  return SizedBox(
                    width: cardWidth,
                    child: GlassCard(
                      child: _EducationCard(
                        title: title,
                        subtitle: subtitle,
                        period: period,
                        details: details,
                        gpa: item.gpa,
                        gpaPrefix: i18n.gpaPrefix,
                      ),
                    ),
                  );
                }),
                ...profile.additionalEducation.map((item) {
                  final title = i18n.isRussian && item.institutionRu.isNotEmpty
                      ? item.institutionRu
                      : item.institution;
                  final subtitle = i18n.isRussian && item.programRu.isNotEmpty
                      ? item.programRu
                      : item.program;
                  final details = i18n.isRussian && item.detailsRu.isNotEmpty
                      ? item.detailsRu
                      : item.details;
                  final period = i18n.isRussian && item.periodRu.isNotEmpty
                      ? item.periodRu
                      : item.period;

                  return SizedBox(
                    width: cardWidth,
                    child: GlassCard(
                      child: _EducationCard(
                        title: title,
                        subtitle: subtitle,
                        period: period,
                        details: details,
                        gpa: item.gpa,
                        gpaPrefix: i18n.gpaPrefix,
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard({
    required this.title,
    required this.subtitle,
    required this.period,
    required this.details,
    required this.gpa,
    required this.gpaPrefix,
  });

  final String title;
  final String subtitle;
  final String period;
  final String details;
  final String gpa;
  final String gpaPrefix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppPalette.accent),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              period,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppPalette.textSecondary),
            ),
            if (gpa.isNotEmpty) ...[
              const SizedBox(width: 14),
              Text(
                '$gpaPrefix $gpa',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppPalette.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        Text(details),
      ],
    );
  }
}
