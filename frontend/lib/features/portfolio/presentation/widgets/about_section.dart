import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/models/profile_model.dart';
import 'glass_card.dart';
import 'section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({required this.profile, required this.i18n, super.key});

  final ProfileModel profile;
  final AppLocalization i18n;

  @override
  Widget build(BuildContext context) {
    final summary = i18n.isRussian && profile.summaryRu.isNotEmpty
        ? profile.summaryRu
        : profile.summary;
    final careerFocus = i18n.isRussian && profile.careerFocusRu.isNotEmpty
        ? profile.careerFocusRu
        : profile.careerFocus;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: i18n.aboutTitle, subtitle: i18n.aboutSubtitle),
        const SizedBox(height: 20),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(summary, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 16),
              Text(
                careerFocus,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
