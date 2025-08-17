class Config {
  static String tokenKey = "token";
  static String refreshTokenKey = "refreshToken";
  static String refreshTokenUrl = "/auth/refresh-token";
  static String tokenPrefix = "Bearer";
  static String responseMessageKey = "message";
  static String msisdnKey = "msisdn";

  static bool enableRefreshToken = true;
  static Function? onAuthFail;

  static Map<String, dynamic> refreshTokenParams = {
    "refresh_token": "",
    "grant_type": "mobile",
    "client_secret": "client_secret",
    "client_id": "client_id",
    "scope": "openid",
  };

  static void configure(
      {String? tokenKey,
      String? refreshTokenKey,
      String? refreshTokenUrl,
      bool? enableRefreshToken,
      void Function()? onAuthFail,
      String? tokenPrefix,
      String? msisdnKey,
      String? responseMessageKey}) {
    if (tokenKey != null) Config.tokenKey = tokenKey;
    if (refreshTokenKey != null) Config.refreshTokenKey = refreshTokenKey;
    if (refreshTokenUrl != null) Config.refreshTokenUrl = refreshTokenUrl;
    if (enableRefreshToken != null)
      Config.enableRefreshToken = enableRefreshToken;
    if (onAuthFail != null) Config.onAuthFail = onAuthFail;
    if (tokenPrefix != null) Config.tokenPrefix = tokenPrefix;
    if (msisdnKey != null) Config.msisdnKey = msisdnKey;
    if (responseMessageKey != null)
      Config.responseMessageKey = responseMessageKey;
  }
}
