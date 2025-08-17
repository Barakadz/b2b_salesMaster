import 'package:core_utility/core_utility.dart';
import 'package:data_layer/data_layer.dart';
import 'package:dio/dio.dart';

class DioErrorHandler extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (Config.enableRefreshToken == false) {
        clearTokenAndRedirect();
        return handler.next(err);
      }
      String? refreshToken = AppStorage().getRefreshToken();

      if (refreshToken == null) {
        AppStorage().removeData("token");
        Config.onAuthFail?.call();
        return handler.next(err);
      }

      bool refreshed = await attemptToRefreshToken(refreshToken);

      if (refreshed) {
        // retry original Request with new token
        final requestOptions = err.requestOptions;
        requestOptions.headers["Authorization"] =
            '${Config.tokenPrefix} ${AppStorage().getToken()}';

        try {
          final response = await Dio().request(requestOptions.path,
              options: Options(
                  method: requestOptions.method,
                  headers: requestOptions.headers,
                  responseType: requestOptions.responseType),
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters);
          return handler.resolve(response);
        } catch (e) {
          clearTokenAndRedirect();
          return handler.next(err);
        }
      } else {
        clearTokenAndRedirect();
        return handler.next(err);
      }
    }

    String errorMessage = _extractErrorMessage(err);

    SnackbarService.showError(errorMessage: errorMessage);

    handler.next(err);
  }

  void clearTokenAndRedirect() {
    AppStorage().clearAll();
    Config.onAuthFail?.call();
  }

  Future<bool> attemptToRefreshToken(String refreshToken) async {
    // try to refresh token
    try {
      final response = await Dio().post(Config.refreshTokenUrl,
          //data: {Config.refreshTokenKey: refreshToken},
          queryParameters: Config.refreshTokenParams);

      if (response.statusCode == 200) {
        String newToken = response.data[Config.tokenKey];
        Api.getInstance().setToken(token: newToken);
        Config.refreshTokenParams["refresh_token"] = newToken;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //handle error
      return false;
    }
  }

  String _handleDioError(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return RepoLocalizations.translate("connection_timeout");
      case DioExceptionType.badCertificate:
        return RepoLocalizations.translate("bad_certificate");
      case DioExceptionType.cancel:
        return RepoLocalizations.translate("request_cancelled");
      case DioExceptionType.connectionError:
        return RepoLocalizations.translate("connection_error");
      case DioExceptionType.unknown:
      default:
        return RepoLocalizations.translate("unexpected_response");
    }
  }

  String _extractErrorMessage(DioException err) {
    final response = err.response;

    // Case: No response at all (timeout, no internet)
    if (response == null) {
      return _handleDioError(err);
    }

    // Try to parse known error response formats
    try {
      final data = response.data;

      if (data is Map<String, dynamic>) {
        if (data.containsKey('detail')) {
          return data['detail'].toString();
        }

        // Handle case: {"email": "email already used"}
        if (data.values.isNotEmpty && data.values.first is String) {
          return data.values.first.toString();
        }
        if (data.values.isNotEmpty && data.values.first is List) {
          return data.values.first[0].toString();
        }
      }
    } catch (_) {
      // Ignore and fall back to status-based message
    }

    // Fall back to HTTP status code-based message
    return _statusCodeMessage(response.statusCode);
  }

  String _statusCodeMessage(int? code) {
    switch (code) {
      case 400:
        return RepoLocalizations.translate("bad_request");
      case 403:
        return RepoLocalizations.translate("forbidden");
      case 404:
        return RepoLocalizations.translate("not_found");
      case 500:
        return RepoLocalizations.translate("server_error");
      default:
        return RepoLocalizations.translate("unexpected_response");
    }
  }
}
