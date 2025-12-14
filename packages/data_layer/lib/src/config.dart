import 'dart:convert';

class Config {
  static String tokenKey = "access_token";
  static String refreshTokenKey = "refresh_token";
  static String refreshTokenUrl = "https://apim.djezzy.dz/uat/djezzy-api/b2b/master/oauth2/token";
  static String tokenPrefix = "Bearer";
  static String responseMessageKey = "message";
  static String msisdnKey = "msisdn";
  static String _clientId = "";
  static String _clientSecret = "";

  static bool enableRefreshToken = true;
  static Function? onAuthFail;

static Map<String, String> refreshTokenHeaders = {
  "accept-encoding": "gzip",
  "authorization": "Basic Rkk3WUZ3WEtmbVJoakJISEJkQ2F5azRLV0gwYTpiT3lqeXFRWDFtY2haX29CcGRMV1BxdmxPX29h",
  "content-type": "application/x-www-form-urlencoded",
  "host": "apim.djezzy.dz",
  "user-agent": "Dart/3.7 (dart:io)",
 // "cookie": "TS01920435=01f6061d6ddd3377bbf5fdc29adecdf473f31c8c669097c693ece9cd91a067335645c50ffb092ddfbde5d1decaedb9d2aca0dbbf80",
};


  static Map<String, dynamic> refreshTokenBody = {
    "grant_type": "refresh_token",
    "refresh_token": "refresh_token_value"
  };

  /// Setters that automatically update the Authorization header
  static set client_id(String id) {
    _clientId = id;
    _updateAuthHeader();
  }

  static String get client_id => _clientId;

  static set client_secret(String secret) {
    _clientSecret = secret;
    _updateAuthHeader();
  }

  static String get client_secret => _clientSecret;

  /// Internal method to recalculate and update the Authorization header
  static void _updateAuthHeader() {
    if (_clientId.isNotEmpty && _clientSecret.isNotEmpty) {
      final credentials = '$_clientId:$_clientSecret';
      final encoded = base64Encode(utf8.encode(credentials));
      refreshTokenHeaders['Authorization'] = 'Basic $encoded';
    }
  }

  static void configure(
      {String? tokenKey,
      String? refreshTokenKey,
      String? refreshTokenUrl,
      bool? enableRefreshToken,
      void Function()? onAuthFail,
      String? tokenPrefix,
      String? msisdnKey,
      String? clientId,
      String? clientSecret,
      String? responseMessageKey}) {
    if (tokenKey != null) Config.tokenKey = tokenKey;
    if (refreshTokenKey != null) Config.refreshTokenKey = refreshTokenKey;
    if (refreshTokenUrl != null) Config.refreshTokenUrl = refreshTokenUrl;
    if (enableRefreshToken != null)
      Config.enableRefreshToken = enableRefreshToken;
    if (onAuthFail != null) Config.onAuthFail = onAuthFail;
    if (tokenPrefix != null) Config.tokenPrefix = tokenPrefix;
    if (msisdnKey != null) Config.msisdnKey = msisdnKey;
    if (clientId != null) Config._clientId = _clientId;
    if (clientSecret != null) Config._clientSecret = _clientSecret;
    if (responseMessageKey != null)
      Config.responseMessageKey = responseMessageKey;
  }
}
