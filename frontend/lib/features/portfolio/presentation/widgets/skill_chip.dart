import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class SkillChip extends StatelessWidget {
  const SkillChip({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppPalette.secondary.withOpacity(0.72),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppPalette.border),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppPalette.primary,
          fontWeight: FontWeight.w600,
          fontSize: 13.5,
        ),
      ),
    );
  }
}
