import 'package:core_utility/core_utility.dart';
import 'package:dio/dio.dart';

class ServerResponseHandler {
  static void handleResponse(Response response) {
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 300) {
      String message = _getErrorMessage(response.statusCode, response.data);
      SnackbarService.showError(errorMessage:message);
    }
  }

  static String _getErrorMessage(int? statusCode, dynamic responseBody) {
    switch (statusCode) {
      case 400:
        return AppLocalizations.translate("bad_request");
      case 401:
        // TODO should redirect to login screen
        return AppLocalizations.translate("unauthorized");
      case 403:
        return AppLocalizations.translate("forbidden");
      case 404:
        return AppLocalizations.translate("not_found");
      case 500:
        return AppLocalizations.translate("server_error");
      default:
        try {
          return responseBody["message"];
        } on Exception catch (_) {
          return AppLocalizations.translate("unexpected_response");
        }
    }
  }
}
