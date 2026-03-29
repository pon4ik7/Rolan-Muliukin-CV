import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/theme/app_theme.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({required this.name, required this.i18n, super.key});

  final String name;
  final AppLocalization i18n;

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Center(
        child: Text(
          i18n.footerText(year: year, name: name),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppPalette.textSecondary,
          ),
        ),
      ),
    );
  }
}
