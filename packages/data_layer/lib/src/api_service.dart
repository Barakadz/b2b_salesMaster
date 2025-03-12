import 'package:core_utility/core_utility.dart';
import 'package:data_layer/data_layer.dart';
import 'package:dio/dio.dart';

/// a class / service that provide simple way of sending http requests and that automatically handle setting token and handling errors via dio interceptors
class Api {
  String _baseUrl = "";
  late Dio _dio;
  String? _token;

  static Api? _instance;

  // Private constructor
  Api._internal(String baseUrl) {
    _baseUrl = baseUrl;
    _dio = Dio()
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.receiveTimeout = const Duration(seconds: 15);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        _token ??= AppStorage().getString('userToken');
        options.headers['Authorization'] = 'Bearer $_token';
        handler.next(options);
      },
    ));

    _dio.interceptors.add(DioInterceptor());
  }

  /// Factory method to return the singleton instance
  static Future<Api> getInstance(String baseUrl) async {
    _instance ??= Api._internal(baseUrl=baseUrl);
    return _instance!;
  }

  set baseUrl(String baseUrl){
    _baseUrl = baseUrl;
  }

  
  Future<void> setToken({required String token, bool? save = true}) async {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    _token = token;

    if (save == true) {
      await AppStorage().setString('userToken', token);
    }
  }

  Future<Response?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        "$_baseUrl/$url",
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      }
      ServerResponseHandler.handleResponse(response);
      return null;
    } catch (e) {
      SnackbarService.showError(errorMessage: RepoLocalizations.translate("something_went_wrong"));
      return null;
    }
  }

  Future<Response?> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        "$_baseUrl/$url",
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      }
      ServerResponseHandler.handleResponse(response);
      return null;
    } catch (e) {
      SnackbarService.showError(errorMessage: RepoLocalizations.translate("something_went_wrong"));
      return null;
    }
  }

  Future<Response?> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        "$_baseUrl/$url",
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      }
      ServerResponseHandler.handleResponse(response);
      return null;
    } catch (e) {
      SnackbarService.showError(errorMessage: RepoLocalizations.translate("something_went_wrong"));
      return null;
    }
  }

  Future<Response?> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        "$_baseUrl/$url",
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      }
      ServerResponseHandler.handleResponse(response);
      return null;
    } catch (e) {
      SnackbarService.showError(errorMessage: RepoLocalizations.translate("something_went_wrong"));
      return null;
    }
  }
}
