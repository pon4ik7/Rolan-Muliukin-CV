import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, required this.subtitle, super.key});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppPalette.secondary,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: 34,
            height: 1.15,
          ),
        ),
      ],
    );
  }
}
