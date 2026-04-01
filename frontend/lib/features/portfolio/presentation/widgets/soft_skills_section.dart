import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../core/theme/app_theme.dart';
import 'glass_card.dart';
import 'section_title.dart';

class SoftSkillsSection extends StatelessWidget {
  const SoftSkillsSection({
    required this.profile,
    required this.i18n,
    super.key,
  });

  final ProfileModel profile;
  final AppLocalization i18n;

  @override
  Widget build(BuildContext context) {
    final skills = i18n.isRussian && profile.softSkillsRu.isNotEmpty
        ? profile.softSkillsRu
        : profile.softSkills;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: i18n.softSkillsTitle,
          subtitle: i18n.softSkillsSubtitle,
        ),
        const SizedBox(height: 20),
        GlassCard(
          child: Column(
            children: skills
                .map(
                  (item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.check_circle_outline,
                      color: AppPalette.accent,
                    ),
                    title: Text(item),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
