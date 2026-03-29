import 'package:flutter/material.dart';

import '../../../../core/models/profile_model.dart';
import 'glass_card.dart';
import 'section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({required this.profile, super.key});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'About', subtitle: 'Engineering Mindset'),
        const SizedBox(height: 20),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.summary, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 16),
              Text(
                profile.careerFocus,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
