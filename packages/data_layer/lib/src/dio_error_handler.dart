import 'package:core_utility/core_utility.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = _handleDioError(err);

    SnackbarService.showError(errorMessage:errorMessage);

    // Pass the error to the next handler
    handler.next(err);
  }

  // TODO translate the messages
  String _handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return "Request to the server was cancelled.";
      case DioExceptionType.sendTimeout || DioException.receiveTimeout:
        return "Connection timeout with the server.";
      default:
        return "Something went wrong. Please try again.";
    }
  }
}
