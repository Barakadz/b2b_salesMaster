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

  //TODO translate message
  static String _getErrorMessage(int? statusCode, dynamic responseBody) {
    switch (statusCode) {
      case 400:
        return "Bad request. Please try again.";
      case 401:
        // TODO should redirect to login screen
        return "Unauthorized. Please log in again.";
      case 403:
        return "Forbidden. You don’t have access.";
      case 404:
        return "Resource not found.";
      case 500:
        return "Server error. Please try again later.";
      default:
        try {
          return responseBody["message"];
        } on Exception catch (_) {
          return "Unexpected server response.";
        }
    }
  }
}
