import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/models/profile_model.dart';
import 'glass_card.dart';
import 'section_title.dart';
import 'skill_chip.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({required this.profile, required this.i18n, super.key});

  final ProfileModel profile;
  final AppLocalization i18n;

  @override
  Widget build(BuildContext context) {
    final stack = i18n.isRussian && profile.techStackRu.isNotEmpty
        ? profile.techStackRu
        : profile.techStack;
    final entries = stack.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: i18n.techStackTitle,
          subtitle: i18n.techStackSubtitle,
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: entries
              .map(
                (entry) => SizedBox(
                  width: 360,
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: entry.value
                              .map((skill) => SkillChip(label: skill))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
