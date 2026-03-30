enum AppLanguage { en, ru }

extension AppLanguageX on AppLanguage {
  String get code => this == AppLanguage.en ? 'EN' : 'RU';

  AppLanguage get toggled =>
      this == AppLanguage.en ? AppLanguage.ru : AppLanguage.en;
}

class AppLocalization {
  const AppLocalization(this.language);

  final AppLanguage language;

  bool get isRussian => language == AppLanguage.ru;

  Map<String, String> get navItems => isRussian ? _ruNavItems : _enNavItems;

  String get contactTooltip => isRussian ? 'Контакты' : 'Contact';
  String get telegram => 'Telegram';
  String get viewProjects => isRussian ? 'Смотреть проекты' : 'View Projects';
  String get contactMe => isRussian ? 'Связаться со мной' : 'Contact Me';
  String get github => 'GitHub';
  String get leetcode => 'LeetCode';
  String get codeforces => 'Codeforces';

  String get switchLanguageButton => language.toggled.code;

  String get switchLanguageTooltip =>
      isRussian ? 'Переключить на английский' : 'Switch to Russian';

  String cvButtonLabel(AppLanguage cvLanguage) => 'CV ${cvLanguage.code}';

  String downloadCvLabel(AppLanguage cvLanguage) => isRussian
      ? 'Скачать CV (${cvLanguage.code})'
      : 'Download CV (${cvLanguage.code})';

  String get aboutTitle => isRussian ? 'О себе' : 'About';

  String get aboutSubtitle =>
      isRussian ? 'Инженерный подход' : 'Engineering Mindset';

  String get techStackTitle => isRussian ? 'Технологии' : 'Tech Stack';

  String get techStackSubtitle => isRussian
      ? 'Ключевые backend-технологии и инструменты'
      : 'Core backend technologies and tools';

  String get experienceTitle => isRussian ? 'Опыт' : 'Experience';

  String get experienceSubtitle => isRussian
      ? 'Командная продуктовая разработка'
      : 'Team Product Development';

  String get projectsTitle => isRussian ? 'Проекты' : 'Projects';

  String get projectsSubtitle => isRussian
      ? 'Backend-системы, которые я разработал'
      : 'Selected Backend Projects';

  String get educationTitle => isRussian ? 'Образование' : 'Education';

  String get educationSubtitle =>
      isRussian ? 'Академическая база' : 'Academic Background';

  String get gpaPrefix => isRussian ? 'Средний балл' : 'GPA';

  String get achievementsTitle =>
      isRussian ? 'Олимпиады и достижения' : 'Olympiads & Achievements';

  String get achievementsSubtitle =>
      isRussian ? 'Соревновательные результаты' : 'Competitive Results';

  String get openRepository =>
      isRussian ? 'Открыть репозиторий' : 'Open repository';

  String get openCertificate =>
      isRussian ? 'Открыть сертификат' : 'Open certificate';

  String get softSkillsTitle => isRussian ? 'Софт-скиллы' : 'Soft Skills';

  String get softSkillsSubtitle =>
      isRussian ? 'Как я работаю в команде' : 'How I Work With Teams';

  String get contactTitle => isRussian ? 'Контакты' : 'Contact';

  String get contactSubtitle => isRussian
      ? 'Давайте делать сильные backend-продукты'
      : "Let's Build Great Backend Products";

  String get contactIntro => isRussian
      ? 'Открыт к позициям Backend-инженера. '
            'Если вы ищете Go/backend специалиста, буду рад связаться.'
      : 'Open to Backend Engineer roles. '
            'If you are hiring for Go/backend positions, feel free to reach out.';

  String get copyEmail => isRussian ? 'Скопировать Email' : 'Copy Email';

  String get emailCopied =>
      isRussian ? 'Email скопирован в буфер обмена' : 'Email copied to clipboard';

  String get retry => isRussian ? 'Повторить' : 'Retry';

  String footerText({required int year, required String name}) => isRussian
      ? '(c) $year $name. Сделано на Flutter + Go.'
      : '(c) $year $name. Built with Flutter + Go.';

  static const Map<String, String> _enNavItems = {
    'about': 'About',
    'stack': 'Tech Stack',
    'experience': 'Experience',
    'projects': 'Projects',
    'education': 'Education',
    'achievements': 'Achievements',
    'contacts': 'Contact',
  };

  static const Map<String, String> _ruNavItems = {
    'about': 'О себе',
    'stack': 'Технологии',
    'experience': 'Опыт',
    'projects': 'Проекты',
    'education': 'Образование',
    'achievements': 'Достижения',
    'contacts': 'Контакты',
  };
}
