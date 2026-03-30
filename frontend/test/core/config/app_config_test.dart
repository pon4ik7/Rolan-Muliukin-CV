import 'package:flutter_test/flutter_test.dart';

import 'package:rolan_portfolio_frontend/core/config/app_config.dart';

void main() {
  test('buildEndpoint uses local proxy path when API_BASE_URL is empty', () {
    expect(AppConfig.apiBaseUrl, '');
    expect(AppConfig.buildEndpoint('/profile'), '/api/v1/profile');
    expect(AppConfig.buildEndpoint('/projects'), '/api/v1/projects');
  });
}
