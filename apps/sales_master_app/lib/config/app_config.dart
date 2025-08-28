enum Environment { production, uat }

class AppConfig {
  // Current environment - change this to switch between environments
  static const Environment currentEnvironment = Environment.uat;

  // Environment Configuration
  static const Map<Environment, Map<String, String>> _environmentConfig = {
    Environment.production: {
      'saleTopic': 'sale_prod',
    },
    Environment.uat: {
      'saleTopic': 'sale_test',
    },
  };

  // firebase topics
  static String get saleTopic =>
      _environmentConfig[currentEnvironment]!['saleTopic']!;
}
