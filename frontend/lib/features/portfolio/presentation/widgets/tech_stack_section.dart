import 'package:flutter/material.dart';

import '../../../../core/models/profile_model.dart';
import 'glass_card.dart';
import 'section_title.dart';
import 'skill_chip.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({required this.profile, super.key});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final entries = profile.techStack.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Tech Stack',
          subtitle: 'Tools I Use To Build Backends',
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
