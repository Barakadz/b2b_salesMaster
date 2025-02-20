import 'package:core_utility/core_utility.dart';
import 'package:data_layer/data_layer.dart';
import 'package:dio/dio.dart';

class Api {
  //final String _baseUrl = "";
  late Dio _dio;
  String? _token;

  static Api? _instance;

  // Private constructor
  Api._internal() {
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

  // Factory method to return the singleton instance
  static Future<Api> getInstance() async {
    if (_instance == null) {
      _instance = Api._internal();
      await _instance!._setAuthorizationHeader();
    }
    return _instance!;
  }

  Future<void> _setAuthorizationHeader() async {
    String? token = AppStorage().getString('userToken');
    if (token != null && token.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
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
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response;
      }
      ServerResponseHandler.handleResponse(response);
      return null;
    } catch (e) {
      SnackbarService.showError(errorMessage:"Something went wrong , please retry");
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
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response;
      }
      ServerResponseHandler.handleResponse(response);
      return null;
    } catch (e) {
      SnackbarService.showError(errorMessage:"Something went wrong , please try again");
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
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response;
      }
      ServerResponseHandler.handleResponse(response);
      return null;
    } catch (e) {
      SnackbarService.showError(errorMessage:"Something went wrong , please try again");
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
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200) {
        return response;
      }
      ServerResponseHandler.handleResponse(response);
      return null;
    } catch (e) {
      SnackbarService.showError(errorMessage:"Something went wrong , please try again");
      return null;
    }
  }
}
