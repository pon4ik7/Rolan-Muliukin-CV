class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  static String buildEndpoint(String path) {
    if (apiBaseUrl.isEmpty) {
      return '/api/v1$path';
    }
    final normalized = apiBaseUrl.endsWith('/')
        ? apiBaseUrl.substring(0, apiBaseUrl.length - 1)
        : apiBaseUrl;
    return '$normalized$path';
  }
}
