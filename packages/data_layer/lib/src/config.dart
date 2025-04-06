class Config {
  static String tokenKey = "token";
  static String refreshTokenKey = "refreshToken";
  static String refreshTokenUrl = "/auth/refresh-token";

  static bool enableRefreshToken = true;
  static Function? onAuthFail;

  static void setTokenKey(String key) {
    tokenKey = key;
  }

  static void setRefreshTokenKey(String key) {
    refreshTokenKey = key;
  }

  ///set the url to fetch new token like refreshTokenUrl =  "/auth/refresh-token";
  static void setRefreshTokenUrl(String key) {
    refreshTokenUrl = key;
  }
}
