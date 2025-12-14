import 'package:core_utility/core_utility.dart';
import 'package:data_layer/data_layer.dart';
import 'package:dio/dio.dart';

/// a class / service that provide simple way of sending http requests and that automatically handle setting token and handling errors via dio interceptors
class Api {
  String? _baseUrl;
  late Dio _dio;
  String? _token;
  String? _refreshToken;

  static Api? _instance;

  // Private constructor
  Api._internal(
      String? baseUrl, Duration connectTimeout, Duration receiveTimeout) {
    _baseUrl = baseUrl;
    _dio = Dio()
      ..options.connectTimeout = connectTimeout
      ..options.receiveTimeout = receiveTimeout;

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        _token ??= AppStorage().getToken();
        if (_token != null) {
          options.headers['Authorization'] = '${Config.tokenPrefix} $_token';
        }
        handler.next(options);
      },
    ));

    _dio.interceptors.add(DioErrorHandler());
  }

  /// Factory method to return the singleton instance
  static Api getInstance(
      {String? baseUrl,
      Duration connectTimeout = const Duration(seconds: 15),
      Duration receiveTimeout = const Duration(seconds: 15)}) {
    _instance ??=
        Api._internal(baseUrl = baseUrl, connectTimeout, receiveTimeout);
    return _instance!;
  }

  void setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  /// set the token value for this api instance
  /// set save = false if you dont want to save it in local storage
  Future<void> setToken({required String token, bool? save = true}) async {
_dio.options.headers['Authorization'] = '${Config.tokenPrefix} $token';
    _token = token;

    if (save == true) {
      await AppStorage().setToken(token);
    }
  }

  /// set the refreshtoken value for this api instance
  /// set save = false if you dont want to save it in local storage
  Future<void> setRefreshToken(
      {required String refreshToken, bool? save = true}) async {
    _refreshToken = refreshToken;

    if (save == true) {
      await AppStorage().setRefreshToken(refreshToken);
    }
  }
String getFullUrl(String endpoint) {
  if (_baseUrl == null || _baseUrl!.isEmpty) {
    throw Exception("Base URL not set in Api");
  }

  // Prevent double slashes
  if (_baseUrl!.endsWith("/")) {
    return "${_baseUrl!}${endpoint.startsWith("/") ? endpoint.substring(1) : endpoint}";
  } else {
    return "$_baseUrl/${endpoint.startsWith("/") ? endpoint.substring(1) : endpoint}";
  }
}

  bool _isSuccess(int? code) => code != null && code >= 200 && code < 300;

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
      if (_isSuccess(response.statusCode)) {
        return response;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
void printOptions(Options? options) {
  if (options == null) {
    print("options is null");
    return;
  }

  print("========= OPTIONS DETAILS =========");
  print("Method: ${options.method}");
  print("SendTimeout: ${options.sendTimeout}");
  print("ReceiveTimeout: ${options.receiveTimeout}");
  print("ContentType: ${options.contentType}");
  print("ResponseType: ${options.responseType}");
  print("FollowRedirects: ${options.followRedirects}");
  print("MaxRedirects: ${options.maxRedirects}");
  print("PersistentConnection: ${options.persistentConnection}");
  print("Headers: ${options.headers}");
  print("Extra: ${options.extra}");
  print("ListFormat: ${options.listFormat}");
  print("===================================");
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
      print("##############################################################");
      print("##############################################################");
      print("##############################################################");
      print("##############################################################");
      print("##############################################################");
      print("##############################################################");
      print("##############################################################");
      print("##############################################################");
      print("##############################################################");
      print("##############################################################");
      print("url==============>{$_baseUrl/$url}");
      print("data============>${data}");
      print("queryParams=============>${queryParameters}");
printOptions(options);
   print("cancelToken===========>${cancelToken}");
      print("onsendProgress===========>${onSendProgress}");
      print("onReceiveProgress================>${onReceiveProgress}");
      print("${response}");
      if (_isSuccess(response.statusCode)) {
        return response;
      }
      return null;
    } catch (e) {
      print(e);
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
      if (_isSuccess(response.statusCode)) {
        return response;
      }
      return null;
    } catch (e) {
      print(e);
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
      if (_isSuccess(response.statusCode)) {
        return response;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
