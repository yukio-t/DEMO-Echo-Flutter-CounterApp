class Env {
  // --dart-define=API_BASE_URL=http://localhost:8080
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080',
  );
}
