import 'dart:convert';

class Config {
  static String tokenKey = "access_token";
  static String refreshTokenKey = "refresh_token";
  static String refreshTokenUrl = "/oauth2/token";
  static String tokenPrefix = "Bearer";
  static String responseMessageKey = "message";
  static String msisdnKey = "msisdn";
  static String _clientId = "";
  static String _clientSecret = "";

  static bool enableRefreshToken = true;
  static Function? onAuthFail;

  static Map<String, dynamic> refreshTokenHeaders = {
    "Content-Type": "application/x-www-form-urlencoded",
    "Cookie":
        "01f6061d6d58ba5d0a22723167783289fbc1e265049594228933a8da4a4b84556d103c9c12890e7c526b2e986715deb1287e4740f5", // just default value , it can be updated
    "Authorization": ""
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
    if (_clientId != null) Config._clientId = _clientId;
    if (_clientSecret != null) Config._clientSecret = _clientSecret;
    if (responseMessageKey != null)
      Config.responseMessageKey = responseMessageKey;
  }
}
