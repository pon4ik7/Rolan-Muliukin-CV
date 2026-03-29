import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/models/profile_model.dart';
import 'glass_card.dart';
import 'section_title.dart';

class SoftSkillsSection extends StatelessWidget {
  const SoftSkillsSection({required this.profile, required this.i18n, super.key});

  final ProfileModel profile;
  final AppLocalization i18n;

  @override
  Widget build(BuildContext context) {
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
            children: profile.softSkills
                .map(
                  (item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.check_circle_outline),
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
