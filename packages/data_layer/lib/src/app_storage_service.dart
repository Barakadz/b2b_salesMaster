import 'package:shared_preferences/shared_preferences.dart';

/// app locale storage service (using shared preferences ) to store key value 
/// data on device locale storage
class AppStorage {
  late final SharedPreferences _sharedPrefs;
  static final AppStorage _appStorageInstance = AppStorage._internal();

  factory AppStorage() => _appStorageInstance;
  AppStorage._internal();

  /// initiate the class on app start , its a singleton class so only one instance will be create across all the app
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

  Future<bool> setInt(String key, int value) async{
    return await _sharedPrefs.setInt(key, value);
  }

  Future<bool> setString(String key, String value) async{
    return await _sharedPrefs.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async{
    return await _sharedPrefs.setBool(key, value);
  }

  Future<bool> clearAll() async{
    return await _sharedPrefs.clear();
  }
}
