import 'package:dio/dio.dart';
import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/config/app_config.dart';
import 'package:sales_master_app/services/push_notification_service.dart';

class AuthService {
  // Auth host (without the trailing slash)
  static const String _authHost =
      'https://apim.djezzy.dz/uat/djezzy-api/b2b/master';

  // Djezzy app UA required by backend (from your curl)
  static const String _userAgent = 'Djezzy/2.7.1';

  // From your curl
  static const String _clientId = 'FI7YFwXKfmRhjBHHBdCayk4KWH0a';
  static const String _clientSecret = 'bOyjyqQX1mchZ_oBpdLWPqvlO_oa';

  /// 1) Request OTP (POST /oauth2/registration?scope=smsotp&client_id=...&msisdn=...)
  /// Body: { "consent-agreement":[{"marketing-notifications":false}], "is-consent":true }

  Future<void> logout() async {
    try {
      final api = Api.getInstance();
      // Use the auth host for this call (Api prepends baseUrl + '/' + url)
      api.setBaseUrl(_authHost);

      print(AppStorage().getMsisdn());
      final String msisdn = formatMsisdn(AppStorage().getMsisdn()!);

      final response = await api.post(
        'oauth2/logout',
        data: {
          'client_id': _clientId,
          'client_secret': _clientSecret,
          'token_type_hint': "access_token",
          'token': AppStorage().getToken(),
        },
        options: Options(
          // must be JSON for this endpoint
          contentType: Headers.jsonContentType,
          headers: {
            'User-Agent': _userAgent,
            // If backend truly requires a specific cookie, add it here:
            // 'Cookie': 'TS01920435=...'
          },
        ),
      );
      PushNotificationService.unsubscribeFromTopic(
        topicName: AppConfig.saleTopic,
      );
      PushNotificationService.removeFirebaseToken();

      // Success sample you showed: { status: 200, ... }
    } catch (e) {
      print('Error sending OTP: $e');
    }
  }

  Future<bool> requestOtp(String msisdnRaw) async {
    try {
      final api = Api.getInstance();
      // Use the auth host for this call (Api prepends baseUrl + '/' + url)
      api.setBaseUrl(_authHost);

      final String msisdn = formatMsisdn(msisdnRaw);

      final response = await api.post(
        'oauth2/registration',
        queryParameters: {
          'scope': 'smsotp',
          'client_id': _clientId,
          'msisdn': msisdn,
        },
        data: {
          'consent-agreement': [
            {'marketing-notifications': false}
          ],
          'is-consent': true,
        },
        options: Options(
          // must be JSON for this endpoint
          contentType: Headers.jsonContentType,
          headers: {
            'User-Agent': _userAgent,
            // If backend truly requires a specific cookie, add it here:
            // 'Cookie': 'TS01920435=...'
          },
        ),
      );

      // Success sample you showed: { status: 200, ... }
      return response != null &&
          (response.statusCode == 200 || response.data?['status'] == 200);
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  /// 2) Verify OTP (POST /oauth2/token) x-www-form-urlencoded
  /// Fields: otp, mobileNumber, scope=openid, client_id, client_secret, grant_type=mobile
  Future<AuthTokens?> verifyOtp({
    required String msisdnRaw,
    required String otp,
  }) async {
    try {
      final api = Api.getInstance();
      // Use the auth host for this call
      api.setBaseUrl(_authHost);

      final String msisdn = formatMsisdn(msisdnRaw);

      final response = await api.post(
        'oauth2/token',
        data: {
          'otp': otp,
          'mobileNumber': msisdn,
          'scope': 'openid',
          'client_id': _clientId,
          'client_secret': _clientSecret,
          'grant_type': 'mobile',
        },
        options: Options(
          // must be form-urlencoded for this endpoint
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'User-Agent': _userAgent,
          },
        ),
      );

      if (response != null &&
          response.data != null &&
          response.data['access_token'] != null) {
        Config.refreshTokenUrl = "https://apim.djezzy.dz/uat/oauth2/token";
        Config.refreshTokenBody["refresh_token"] =
            response.data["refresh_token"];
        Config.client_secret = _clientSecret;
        Config.client_id = _clientId;
        PushNotificationService.subscribeToTopic(
          topicName: AppConfig.saleTopic,
        );

        return AuthTokens.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('Error verifying OTP: $e');
      return null;
    }
  }

  /// Helper to compute the **post-login base URL** your app needs:
  /// https://.../api/v1/{213xxxxxxxxx}
  String userScopedBaseUrl(String msisdnRaw) {
    final msisdn = formatMsisdn(msisdnRaw);
    return '$_authHost/api/v1/$msisdn';
  }

  /// Format msisdn: remove leading 0 if present, prepend 213
  String formatMsisdn(String msisdn) {
    final s = msisdn.trim();
    if (s.startsWith('213')) return s;
    final cleaned = s.startsWith('0') ? s.substring(1) : s;
    return '213$cleaned';
  }
}

/// Simple tokens model for convenience
class AuthTokens {
  final String accessToken;
  final String refreshToken;
  final String? tokenType;
  final int? expiresIn;
  final String? idToken;

  AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType,
    this.expiresIn,
    this.idToken,
  });

  factory AuthTokens.fromJson(Map<String, dynamic> json) => AuthTokens(
        accessToken: json['access_token'] as String,
        refreshToken: json['refresh_token'] as String,
        tokenType: json['token_type'] as String?,
        expiresIn: json['expires_in'] is int ? json['expires_in'] : null,
        idToken: json['id_token'] as String?,
      );
}
