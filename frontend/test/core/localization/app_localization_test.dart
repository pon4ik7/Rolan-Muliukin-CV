import 'package:flutter_test/flutter_test.dart';

import 'package:rolan_portfolio_frontend/core/localization/app_localization.dart';

void main() {
  group('AppLanguage extension', () {
    test('returns language code', () {
      expect(AppLanguage.en.code, 'EN');
      expect(AppLanguage.ru.code, 'RU');
    });

    test('toggles language', () {
      expect(AppLanguage.en.toggled, AppLanguage.ru);
      expect(AppLanguage.ru.toggled, AppLanguage.en);
    });
  });

  group('AppLocalization', () {
    test('provides russian labels', () {
      const i18n = AppLocalization(AppLanguage.ru);

      expect(i18n.isRussian, isTrue);
      expect(i18n.aboutTitle, 'О себе');
      expect(i18n.projectsTitle, 'Проекты');
      expect(i18n.downloadCvLabel(AppLanguage.ru), 'Скачать CV (RU)');
      expect(i18n.retry, 'Повторить');
      expect(i18n.navItems['contacts'], 'Контакты');
    });

    test('provides english labels', () {
      const i18n = AppLocalization(AppLanguage.en);

      expect(i18n.isRussian, isFalse);
      expect(i18n.aboutTitle, 'About');
      expect(i18n.projectsTitle, 'Projects');
      expect(i18n.downloadCvLabel(AppLanguage.en), 'Download CV (EN)');
      expect(i18n.retry, 'Retry');
      expect(i18n.navItems['contacts'], 'Contact');
    });
  });
}
