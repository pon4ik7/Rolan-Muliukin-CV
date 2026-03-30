import 'package:flutter_test/flutter_test.dart';

import 'package:rolan_portfolio_frontend/core/models/achievement_model.dart';
import 'package:rolan_portfolio_frontend/core/models/experience_model.dart';
import 'package:rolan_portfolio_frontend/core/models/portfolio_bundle.dart';
import 'package:rolan_portfolio_frontend/core/models/profile_model.dart';
import 'package:rolan_portfolio_frontend/core/models/project_model.dart';
import 'package:rolan_portfolio_frontend/core/services/api_service.dart';
import 'package:rolan_portfolio_frontend/features/portfolio/presentation/state/portfolio_controller.dart';

class FakeApiService extends ApiService {
  FakeApiService(this._loader);

  final Future<PortfolioBundle> Function() _loader;

  @override
  Future<PortfolioBundle> fetchPortfolio() => _loader();
}

PortfolioBundle sampleBundle() {
  return PortfolioBundle(
    profile: ProfileModel.fromJson({
      'name': 'Rolan Muliukin',
      'role': 'Backend Developer',
      'headline': 'h',
      'summary': 's',
      'availabilityBadge': 'a',
      'careerFocus': 'c',
      'contacts': {
        'phone': '+70000000000',
        'email': 'mail@example.com',
        'telegram': '@rolan',
        'location': 'Innopolis',
      },
      'links': {
        'github': '',
        'leetcode': '',
        'codeforces': '',
        'telegram': '',
        'university': '',
        'cvDownload': '',
        'cvDownloadEn': '',
        'cvDownloadRu': '',
        'contactMail': '',
      },
      'primaryStack': ['Go'],
      'techStack': {
        'Backend': ['Go'],
      },
      'education': [],
      'additionalEducation': [],
      'softSkills': [],
    }),
    projects: [
      ProjectModel.fromJson({
        'id': 'p1',
        'name': 'Project',
        'role': 'Backend',
        'description': 'desc',
        'highlights': ['h1'],
        'techStack': ['Go'],
        'repository': '',
      }),
    ],
    experience: [
      ExperienceModel.fromJson({
        'id': 'e1',
        'title': 'Backend Developer',
        'organization': 'Team',
        'period': '2025',
        'description': 'desc',
        'highlights': ['h1'],
        'techStack': ['Go'],
      }),
    ],
    achievements: [
      AchievementModel.fromJson({
        'id': 'a1',
        'title': 'ICPC',
        'category': 'Olympiads',
        'result': 'III',
        'description': 'desc',
        'link': '',
      }),
    ],
  );
}

void main() {
  test('load sets ready status and exposes fetched bundle', () async {
    final bundle = sampleBundle();
    final controller = PortfolioController(
      apiService: FakeApiService(() async => bundle),
    );
    final statuses = <PortfolioStatus>[];

    controller.addListener(() {
      statuses.add(controller.status);
    });

    await controller.load();

    expect(statuses, [PortfolioStatus.loading, PortfolioStatus.ready]);
    expect(controller.status, PortfolioStatus.ready);
    expect(controller.bundle, bundle);
    expect(controller.errorMessage, isEmpty);
  });

  test('load sets error status and message on failure', () async {
    final controller = PortfolioController(
      apiService: FakeApiService(() async {
        throw Exception('network down');
      }),
    );
    final statuses = <PortfolioStatus>[];

    controller.addListener(() {
      statuses.add(controller.status);
    });

    await controller.load();

    expect(statuses, [PortfolioStatus.loading, PortfolioStatus.error]);
    expect(controller.status, PortfolioStatus.error);
    expect(controller.bundle, isNull);
    expect(controller.errorMessage, isNotEmpty);
  });
}
