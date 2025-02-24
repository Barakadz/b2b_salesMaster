import 'package:core_utility/core_utility.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = _handleDioError(err);

    SnackbarService.showError(errorMessage:errorMessage);

    handler.next(err);
  }

  String _handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return AppLocalizations.translate("request_cancelled");
      case DioExceptionType.sendTimeout || DioException.receiveTimeout:
        return AppLocalizations.translate("connection_timeout");
      default:
        return AppLocalizations.translate("something_went_wrong");
    }
  }
}
