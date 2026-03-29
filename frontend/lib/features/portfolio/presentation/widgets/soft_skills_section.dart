import 'package:flutter/material.dart';

import '../../../../core/models/profile_model.dart';
import 'glass_card.dart';
import 'section_title.dart';

class SoftSkillsSection extends StatelessWidget {
  const SoftSkillsSection({required this.profile, super.key});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Soft Skills',
          subtitle: 'How I Work With Teams',
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
