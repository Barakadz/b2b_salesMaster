enum Environment { production, uat }

class AppConfig {
  // Current environment - change this to switch between environments
  static const Environment currentEnvironment = Environment.uat;

  // Environment Configuration
  static const Map<Environment, Map<String, String>> _environmentConfig = {
    Environment.production: {
      'saleTopic': 'sale_prod',
      'apiBaseUrl': 'https://apim.djezzy.dz/prod/djezzy-api/b2b/master/api/v1',
      'authHost': 'https://apim.djezzy.dz/uat/djezzy-api/b2b/master',
      'userAgent': 'Djezzy/2.7.1',
      'clientId': 'FI7YFwXKfmRhjBHHBdCayk4KWH0a',
      'clientSecret': 'bOyjyqQX1mchZ_oBpdLWPqvlO_oa',
    },
    Environment.uat: {
      'saleTopic': 'sale_test',
      'apiBaseUrl': 'https://apim.djezzy.dz/prod/djezzy-api/b2b/master/api/v1',
      'authHost': 'https://apim.djezzy.dz/uat/djezzy-api/b2b/master',
      'userAgent': 'Djezzy/2.7.1',
      'clientId': 'FI7YFwXKfmRhjBHHBdCayk4KWH0a',
      'clientSecret': 'bOyjyqQX1mchZ_oBpdLWPqvlO_oa',
    },
  };

  // firebase topics
  static String get saleTopic =>
      _environmentConfig[currentEnvironment]!['saleTopic']!;

  static String get apiBaseUrl =>
      _environmentConfig[currentEnvironment]!['apiBaseUrl']!;

  static String get authHost =>
      _environmentConfig[currentEnvironment]!['authHost']!;

  static String get userAgent =>
      _environmentConfig[currentEnvironment]!['userAgent']!;

  static String get clientId =>
      _environmentConfig[currentEnvironment]!['clientId']!;

  static String get clientSecret =>
      _environmentConfig[currentEnvironment]!['clientSecret']!;
}
