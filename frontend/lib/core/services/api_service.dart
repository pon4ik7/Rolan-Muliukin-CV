import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/achievement_model.dart';
import '../models/experience_model.dart';
import '../models/portfolio_bundle.dart';
import '../models/profile_model.dart';
import '../models/project_model.dart';

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<PortfolioBundle> fetchPortfolio() async {
    final results = await Future.wait([
      _fetchMap('/profile'),
      _fetchList('/projects'),
      _fetchList('/experience'),
      _fetchList('/achievements'),
    ]);

    return PortfolioBundle(
      profile: ProfileModel.fromJson(results[0] as Map<String, dynamic>),
      projects: (results[1] as List<dynamic>)
          .map((item) => ProjectModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      experience: (results[2] as List<dynamic>)
          .map((item) => ExperienceModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      achievements: (results[3] as List<dynamic>)
          .map((item) => AchievementModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<Map<String, dynamic>> _fetchMap(String path) async {
    final payload = await _fetch(path);
    if (payload is! Map<String, dynamic>) {
      throw const FormatException('Expected map payload');
    }
    return payload;
  }

  Future<List<dynamic>> _fetchList(String path) async {
    final payload = await _fetch(path);
    if (payload is! List<dynamic>) {
      throw const FormatException('Expected list payload');
    }
    return payload;
  }

  Future<dynamic> _fetch(String path) async {
    final uri = Uri.parse(AppConfig.buildEndpoint(path));
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('API request failed: ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final status = decoded['status'] as String? ?? 'error';
    if (status != 'success') {
      throw Exception('API returned an error');
    }

    return decoded['data'];
  }
}
