import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:rolan_portfolio_frontend/core/services/api_service.dart';

void main() {
  String successEnvelope(Object data) {
    return jsonEncode({
      'status': 'success',
      'data': data,
    });
  }

  test('fetchPortfolio returns parsed bundle on success responses', () async {
    final client = MockClient((request) async {
      switch (request.url.path) {
        case '/api/v1/profile':
          return http.Response(
            successEnvelope({
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
            200,
          );
        case '/api/v1/projects':
          return http.Response(
            successEnvelope([
              {
                'id': 'p1',
                'name': 'Project',
                'role': 'Backend',
                'description': 'desc',
                'highlights': ['h1'],
                'techStack': ['Go'],
                'repository': '',
              },
            ]),
            200,
          );
        case '/api/v1/experience':
          return http.Response(
            successEnvelope([
              {
                'id': 'e1',
                'title': 'Backend Developer',
                'organization': 'Team',
                'period': '2025',
                'description': 'desc',
                'highlights': ['h1'],
                'techStack': ['Go'],
              },
            ]),
            200,
          );
        case '/api/v1/achievements':
          return http.Response(
            successEnvelope([
              {
                'id': 'a1',
                'title': 'ICPC',
                'category': 'Olympiads',
                'result': 'III',
                'description': 'desc',
                'link': '',
              },
            ]),
            200,
          );
        default:
          return http.Response('not found', 404);
      }
    });

    final service = ApiService(client: client);
    final bundle = await service.fetchPortfolio();

    expect(bundle.profile.name, 'Rolan Muliukin');
    expect(bundle.projects.single.id, 'p1');
    expect(bundle.experience.single.id, 'e1');
    expect(bundle.achievements.single.id, 'a1');
  });

  test('fetchPortfolio throws when any endpoint returns non-200', () async {
    final client = MockClient((request) async {
      if (request.url.path == '/api/v1/projects') {
        return http.Response('boom', 500);
      }
      return http.Response(successEnvelope(<String, dynamic>{}), 200);
    });

    final service = ApiService(client: client);

    await expectLater(service.fetchPortfolio(), throwsA(isA<Exception>()));
  });

  test('fetchPortfolio throws when API response status is error', () async {
    final client = MockClient((_) async {
      return http.Response(
        jsonEncode({
          'status': 'error',
          'error': {'message': 'bad'},
        }),
        200,
      );
    });

    final service = ApiService(client: client);

    await expectLater(service.fetchPortfolio(), throwsA(isA<Exception>()));
  });

  test('fetchPortfolio throws FormatException when payload shape is invalid', () async {
    final client = MockClient((request) async {
      if (request.url.path == '/api/v1/profile') {
        return http.Response(successEnvelope([]), 200);
      }
      return http.Response(successEnvelope([]), 200);
    });

    final service = ApiService(client: client);

    await expectLater(service.fetchPortfolio(), throwsA(isA<FormatException>()));
  });
}
