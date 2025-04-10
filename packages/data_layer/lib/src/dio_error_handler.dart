import 'package:core_utility/core_utility.dart';
import 'package:data_layer/data_layer.dart';
import 'package:data_layer/src/config.dart';
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

    String errorMessage = _handleDioError(err);

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
      final response = await Dio().post(
        Config.refreshTokenUrl,
        data: {Config.refreshTokenKey: refreshToken},
      );

      if (response.statusCode == 200) {
        String newToken = response.data[Config.tokenKey];
        Api.getInstance().setToken(token: newToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //handle error
      return false;
    }
  }

  String _handleDioError(DioException dioError) {
    print("dio error handler");
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return RepoLocalizations.translate("request_cancelled");
      case DioExceptionType.sendTimeout || DioException.receiveTimeout:
        return RepoLocalizations.translate("connection_timeout");
      default:
        return RepoLocalizations.translate("something_went_wrong");
    }
  }
}
