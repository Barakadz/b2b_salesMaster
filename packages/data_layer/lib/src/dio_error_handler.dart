import 'package:core_utility/core_utility.dart';
import 'package:data_layer/data_layer.dart';
import 'package:dio/dio.dart';

class DioErrorHandler extends Interceptor {
  bool isRefreshing = false;
final List<ErrorInterceptorHandler> _pendingRequests = [];

// @override
//  void onResponse(Response response, ResponseInterceptorHandler handler) async {
//   print("#########################################################################################BBBBBBBBBBBBBBBBBBBB");
//   print("#########################################################################################BBBBBBBBBBBBBBBBBBBB");
//   print("#########################################################################################BBBBBBBBBBBBBBBBBBBB");
//   print("#########################################################################################BBBBBBBBBBBBBBBBBBBB");
//   print("#########################################################################################BBBBBBBBBBBBBBBBBBBB");
//   print("#########################################################################################BBBBBBBBBBBBBBBBBBBB");
//   print("#########################################################################################BBBBBBBBBBBBBBBBBBBB");
//   print("#########################################################################################BBBBBBBBBBBBBBBBBBBB");
//   print("#########################################################################################BBBBBBBBBBBBBBBBBBBB");
//   print("#########################################################################################BBBBBBBBBBBBBBBBBBBB");
//   print("#########################################################################################BBBBBBBBBBBBBBBBBBBB");
 
//     // Example: If API returns a specific code/message that requires token refresh
//    // your API signal
//       print("Refresh token required after successful response");

//       String? refreshToken = await AppStorage().getRefreshToken();
//       print(refreshToken);
//       if (refreshToken != null) {
//         bool refreshed = await attemptToRefreshToken(refreshToken);
//         if (refreshed) {
//           print("Token refreshed successfully after success response");
//         } else {
//           print("Failed to refresh token");
//           // AppStorage().clearAll();
//           // Config.onAuthFail?.call();
//         }
//       }
   

//     handler.next(response); // continue normal response handling
//   }
 
@override
void onError(DioException err, ErrorInterceptorHandler handler) async {
  print("########################################################################");
  print("########################################################################");
  print("########################################################################");

  if (err.response?.statusCode == 401) {
    String? refreshToken = await AppStorage().getRefreshToken();
    
    if (refreshToken == null) {
      print("token null clearing AppStorage and running callback");
      clearTokenAndRedirect();
      return handler.next(err);
    }

    // Handle concurrent refresh requests
    if (isRefreshing) {
      // Queue this request to retry after refresh completes
      _pendingRequests.add(handler);
      return;
    }

    isRefreshing = true;

    try {
      bool refreshed = await attemptToRefreshToken(refreshToken);

      if (refreshed) {
                print("------------------------------------------------------------------");
               print("------------------------------------------------------------------");
                print("------------------------------------------------------------------");
                print("------------------------------------------------------------------");
                print("------------------------------------------------------------------");
                print("------------------------------------------------------------------");
        print("token refreshed");
        print("sending request again with new token");
        // Get the new token (await if async)
        String? newToken = await AppStorage().getToken();
        print("-------------------------------new token =========>$newToken");
        if (newToken == null) {
          throw Exception("New token is null after refresh");
        }

        // Retry the original request
        final response = await _retryRequest(err.requestOptions, newToken);
        handler.resolve(response);
        print("#####################################################################################");
        print(response);
        // Retry all pending requests
        for (var pendingHandler in _pendingRequests) {
          print("pendingHandler");
          try {
            final pendingResponse = await _retryRequest(
              (pendingHandler as dynamic).error.requestOptions, 
              newToken
            );
            print("pendingResponseeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
            pendingHandler.resolve(pendingResponse);
          } catch (e) {
            pendingHandler.next((pendingHandler as dynamic).error);
          }
        }
        _pendingRequests.clear();
        
      } else {
        print("not refreshed, clearing AppStorage and redirecting");
        clearTokenAndRedirect();
        handler.next(err);
        
        // Reject all pending requests
        for (var pendingHandler in _pendingRequests) {
          pendingHandler.next((pendingHandler as dynamic).error);
        }
        _pendingRequests.clear();
      }
    } catch (e, trace) {
      print("error during token refresh, trace: $trace");
      print("clearing AppStorage and running callback");
      clearTokenAndRedirect();
      handler.next(err);
      
      // Reject all pending requests
      for (var pendingHandler in _pendingRequests) {
        pendingHandler.next((pendingHandler as dynamic).error);
      }
      _pendingRequests.clear();
    } finally {
      isRefreshing = false;
    }
    
    return;
  }

  String errorMessage = _extractErrorMessage(err);
  SnackbarService.showError(errorMessage: errorMessage);
  handler.next(err);
}

// Helper method to retry requests
Future<Response> _retryRequest(RequestOptions requestOptions, String token) async {
  requestOptions.headers["Authorization"] = '${Config.tokenPrefix} $token';
  
  // Use the same Dio instance (assuming it's available in your class)
  // If not, pass it as a parameter to the interceptor
  final options = Options(
    method: requestOptions.method,
    headers: requestOptions.headers,
    responseType: requestOptions.responseType,
    contentType: requestOptions.contentType,
    validateStatus: requestOptions.validateStatus,
    receiveTimeout: requestOptions.receiveTimeout,
    sendTimeout: requestOptions.sendTimeout,
  );

  return await Dio().request(
    requestOptions.path,
    options: options,
    data: requestOptions.data,
    queryParameters: requestOptions.queryParameters,
  );
}



  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) async {
  //   print("########################################################################");
  //  print("########################################################################");
  //   print("########################################################################");
 

  //   if (err.response?.statusCode == 401) {
  //     // if (Config.enableRefreshToken == false) {
  //     //   print(
  //     //       "refresh token not enabled clearing AppStorage and runing callback");
  //     //   clearTokenAndRedirect();
  //     //   return handler.next(err);
  //     // }
  //     String? refreshToken = await AppStorage().getRefreshToken();
  //     if (refreshToken == null) {
  //       print("token null clearing AppStorage and runing callback");
  //       clearTokenAndRedirect();
  //       return handler.next(err);
  //     }

  //     // if (refreshToken == null) {
  //     //   print("refresh token null");
  //     //   print(Config.refreshTokenKey);
  //     //   AppStorage().removeData(Config.tokenKey);
  //     //   Config.onAuthFail?.call();
  //     //   return handler.next(err);
  //     // }

  //     bool refreshed = await attemptToRefreshToken(refreshToken);

  //     if (refreshed) {
  //       print("token refreshed");
  //       print("sending request again with new token");
  //       // retry original Request with new token
  //       final requestOptions = err.requestOptions;
  //       requestOptions.headers["Authorization"] =
  //           '${Config.tokenPrefix} ${AppStorage().getToken()}';

  //       try {
  //         final response = await Dio().request(requestOptions.path,
  //             options: Options(
  //                 method: requestOptions.method,
  //                 headers: requestOptions.headers,
  //                 responseType: requestOptions.responseType),
  //             data: requestOptions.data,
  //             queryParameters: requestOptions.queryParameters);
  //         return handler.resolve(response);
  //       } catch (e, trace) {
  //         //clearTokenAndRedirect();
  //         print(
  //             "error while re sending request with new token , trace : $trace");
  //         print("cleanring AppStorage and rening callback");
  //         clearTokenAndRedirect();
  //         return handler.next(err);
  //       }
  //     } else {
  //       //clearTokenAndRedirect();
  //       print("not refreshed , clearing AppStorage and redirectling");
  //       clearTokenAndRedirect();
  //       return handler.next(err);
  //     }
  //   }

  //   String errorMessage = _extractErrorMessage(err);

  //   SnackbarService.showError(errorMessage: errorMessage);

  //   handler.next(err);
  // }

  void clearTokenAndRedirect() {
    AppStorage().clearAll();
    Config.onAuthFail?.call();
  }

  Future<bool> attemptToRefreshToken(String refreshToken) async {
  try {
    print("sending refresh token request");

    final response = await Dio().post(
      Config.refreshTokenUrl,
      data: {
        ...Config.refreshTokenBody,
        "refresh_token": refreshToken,
      },
      options: Options(
        headers: Config.refreshTokenHeaders,
      ),
    );
print("response====================>${response.statusCode}");
print("response+++++++++++${response}");
    if (response.statusCode == 200) {
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
print("old refresh token======>$refreshToken");

      String newToken = response.data[Config.tokenKey];
      String refresh_token = response.data[Config.refreshTokenKey];
print("new token ================>$newToken");
print("new refresh toen =============>$refresh_token");
      Api.getInstance().setToken(token: newToken);
      Api.getInstance().setRefreshToken(refreshToken: refresh_token);

      print("got new credentials : $newToken, $refresh_token");
      return true;
    } else {
      print("could not refresh token, status code: ${response.statusCode}");
      return false;
    }
  } catch (e, trace) {
    print("Failed to refresh token: $e");
    print(trace);
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
