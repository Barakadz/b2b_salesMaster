class Config {
  static String tokenKey = "token";
  static String refreshTokenKey = "refreshToken";
  static String refreshTokenUrl = "/auth/refresh-token";
  static String tokenPrefix = "Bearer";
  static String responseMessageKey = "message";

  static bool enableRefreshToken = true;
  static Function? onAuthFail;

  static void configure(
      {String? tokenKey,
      String? refreshTokenKey,
      String? refreshTokenUrl,
      bool? enableRefreshToken,
      void Function()? onAuthFail,
      String? tokenPrefix,
      String? responseMessageKey}) {
    if (tokenKey != null) Config.tokenKey = tokenKey;
    if (refreshTokenKey != null) Config.refreshTokenKey = refreshTokenKey;
    if (refreshTokenUrl != null) Config.refreshTokenUrl = refreshTokenUrl;
    if (enableRefreshToken != null)
      Config.enableRefreshToken = enableRefreshToken;
    if (onAuthFail != null) Config.onAuthFail = onAuthFail;
    if (tokenPrefix != null) Config.tokenPrefix = tokenPrefix;
    if (responseMessageKey != null)
      Config.responseMessageKey = responseMessageKey;
  }
}
