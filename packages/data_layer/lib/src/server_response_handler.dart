import 'package:core_utility/core_utility.dart';
import 'package:data_layer/src/config.dart';
import 'package:dio/dio.dart';

/// class to handle server response (errors)
class ServerResponseHandler {
  static void handleResponse(Response response) {
    String message = _getErrorMessage(response.statusCode, response.data);
    SnackbarService.showError(errorMessage: message);
  }

  static String _getErrorMessage(int? statusCode, dynamic responseBody) {
    print("server response handler");
    switch (statusCode) {
      case 400:
        return RepoLocalizations.translate("bad_request");
      // case 401:
      //   // TODO should redirect to login screen
      //   return RepoLocalizations.translate("unauthorized");
      case 403:
        return RepoLocalizations.translate("forbidden");
      case 404:
        return RepoLocalizations.translate("not_found");
      case 500:
        return RepoLocalizations.translate("server_error");
      default:
        try {
          return responseBody[Config.responseMessageKey];
        } on Exception catch (_) {
          return RepoLocalizations.translate("unexpected_response");
        }
    }
  }
}
