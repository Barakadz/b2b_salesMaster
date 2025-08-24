import 'package:data_layer/src/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// app locale storage service (using shared preferences ) to store key value
/// data on device locale storage
class AppStorage {
  late final SharedPreferences _sharedPrefs;
  static final AppStorage _appStorageInstance = AppStorage._internal();

  factory AppStorage() => _appStorageInstance;
  AppStorage._internal();

  /// initiate the class on app start , its a singleton class so only one instance will be created across all the app
  /// example usage :
  /// ```dart
  /// void main() async {
  /// WidgetsFlutterBinding.ensureInitialized();
  ///
  /// await AppStorage().init();
  /// runApp(MyApp());
  /// }
  /// ```
  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  void delete(String key) {
    _sharedPrefs.remove(key);
  }

  String? getString(String key) {
    return _sharedPrefs.getString(key);
  }

  int? getInt(String key) {
    return _sharedPrefs.getInt(key);
  }

  bool? getBool(String key) {
    return _sharedPrefs.getBool(key);
  }

  String? getToken() {
    return _sharedPrefs.getString(Config.tokenKey);
  }

  Future<bool> setToken(String token) async {
    return await _sharedPrefs.setString(Config.tokenKey, token);
  }

  String? getRefreshToken() {
    final val = _sharedPrefs.getString(Config.refreshTokenKey);
    print(
        "Loading refreshToken under key: ${Config.refreshTokenKey}, got: $val");
    return _sharedPrefs.getString(Config.refreshTokenKey);
  }

  String? getMsisdn() {
    return _sharedPrefs.getString(Config.msisdnKey);
  }

  Future<bool> setRefreshToken(String refreshToken) async {
    print(
        "Saving refreshToken under key: ${Config.refreshTokenKey}, value: $refreshToken");
    return await _sharedPrefs.setString(Config.refreshTokenKey, refreshToken);
  }

  Future<bool> removeData(String key) async {
    return await _sharedPrefs.remove(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _sharedPrefs.setInt(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _sharedPrefs.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPrefs.setBool(key, value);
  }

  Future<bool> setMsisdn(String msisdn) async {
    return await _sharedPrefs.setString(Config.msisdnKey, msisdn);
  }

  Future<bool> clearAll() async {
    return await _sharedPrefs.clear();
  }
}
