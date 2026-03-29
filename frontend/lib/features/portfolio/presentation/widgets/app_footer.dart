import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Center(
        child: Text(
          '(c) $year $name. Built with Flutter + Go.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppPalette.textSecondary,
          ),
        ),
      ),
    );
  }
}
