import 'package:flutter_test/flutter_test.dart';

import 'package:rolan_portfolio_frontend/core/models/achievement_model.dart';
import 'package:rolan_portfolio_frontend/core/models/experience_model.dart';
import 'package:rolan_portfolio_frontend/core/models/profile_model.dart';
import 'package:rolan_portfolio_frontend/core/models/project_model.dart';

void main() {
  group('ProfileModel.fromJson', () {
    test('parses localized and nested fields', () {
      final model = ProfileModel.fromJson({
        'name': 'Rolan Muliukin',
        'nameRu': 'Ролан Мулюкин',
        'role': 'Backend Developer',
        'roleRu': 'Backend разработчик',
        'headline': 'Headline',
        'headlineRu': 'Заголовок',
        'summary': 'Summary',
        'summaryRu': 'Описание',
        'availabilityBadge': 'Available',
        'availabilityBadgeRu': 'Доступен',
        'careerFocus': 'Focus',
        'careerFocusRu': 'Фокус',
        'contacts': {
          'phone': '+70000000000',
          'email': 'mail@example.com',
          'telegram': '@rolan',
          'location': 'Innopolis',
          'locationRu': 'Иннополис',
        },
        'links': {
          'github': 'https://github.com/example',
          'leetcode': '',
          'codeforces': '',
          'telegram': '',
          'university': '',
          'cvDownload': '/cv/default.pdf',
          'cvDownloadEn': '/cv/en.pdf',
          'cvDownloadRu': '/cv/ru.pdf',
          'contactMail': 'mailto:mail@example.com',
        },
        'primaryStack': ['Go', 'PostgreSQL'],
        'techStack': {
          'Backend': ['Go', 'REST API'],
        },
        'techStackRu': {
          'Бэкенд': ['Go', 'REST API'],
        },
        'education': [
          {
            'institution': 'Innopolis University',
            'institutionRu': 'Университет Иннополис',
            'program': 'Information Systems Engineering',
            'programRu': 'Инженерия информационных систем',
            'gpa': '4.86/5.0',
            'period': '2024-2028',
            'periodRu': '2024-2028',
            'details': 'Details',
            'detailsRu': 'Детали',
          },
        ],
        'additionalEducation': const [],
        'softSkills': ['Teamwork'],
        'softSkillsRu': ['Командная работа'],
      });

      expect(model.name, 'Rolan Muliukin');
      expect(model.nameRu, 'Ролан Мулюкин');
      expect(model.roleRu, 'Backend разработчик');
      expect(model.contacts.locationRu, 'Иннополис');
      expect(model.techStack['Backend'], ['Go', 'REST API']);
      expect(model.techStackRu['Бэкенд'], ['Go', 'REST API']);
      expect(model.education.first.institutionRu, 'Университет Иннополис');
      expect(model.education.first.periodRu, '2024-2028');
      expect(model.links.hasCvEn, isTrue);
      expect(model.links.hasCvRu, isTrue);
    });

    test('uses safe defaults for missing optional fields', () {
      final model = ProfileModel.fromJson({
        'name': 'Rolan',
      });

      expect(model.role, '');
      expect(model.contacts.email, '');
      expect(model.links.cvDownload, '');
      expect(model.primaryStack, isEmpty);
      expect(model.techStack, isEmpty);
      expect(model.education, isEmpty);
    });
  });

  group('ProjectModel.fromJson', () {
    test('parses localized fields', () {
      final model = ProjectModel.fromJson({
        'id': 'p1',
        'name': 'Room Booking',
        'nameRu': 'Бронирование переговорных',
        'role': 'Backend Developer',
        'roleRu': 'Backend разработчик',
        'description': 'desc',
        'descriptionRu': 'описание',
        'highlights': ['one'],
        'highlightsRu': ['раз'],
        'techStack': ['Go'],
        'repository': 'https://github.com/example/repo',
      });

      expect(model.nameRu, 'Бронирование переговорных');
      expect(model.highlightsRu, ['раз']);
      expect(model.repository, 'https://github.com/example/repo');
    });
  });

  group('ExperienceModel.fromJson', () {
    test('parses localized fields and lists', () {
      final model = ExperienceModel.fromJson({
        'id': 'e1',
        'title': 'Backend Developer',
        'titleRu': 'Backend разработчик',
        'organization': 'Team',
        'organizationRu': 'Команда',
        'period': 'May 2025 - August 2026',
        'periodRu': 'Май 2025 - Август 2026',
        'description': 'desc',
        'descriptionRu': 'описание',
        'highlights': ['h1'],
        'highlightsRu': ['п1'],
        'techStack': ['Go', 'Docker'],
      });

      expect(model.periodRu, 'Май 2025 - Август 2026');
      expect(model.highlightsRu, ['п1']);
      expect(model.techStack.length, 2);
    });
  });

  group('AchievementModel.fromJson', () {
    test('parses localized fields', () {
      final model = AchievementModel.fromJson({
        'id': 'a1',
        'title': 'ICPC',
        'titleRu': 'ICPC',
        'category': 'Olympiads',
        'categoryRu': 'Олимпиады',
        'result': 'III degree diploma',
        'resultRu': 'Диплом III степени',
        'description': 'desc',
        'descriptionRu': 'описание',
        'link': 'https://example.com',
      });

      expect(model.categoryRu, 'Олимпиады');
      expect(model.resultRu, 'Диплом III степени');
      expect(model.link, 'https://example.com');
    });
  });
}
