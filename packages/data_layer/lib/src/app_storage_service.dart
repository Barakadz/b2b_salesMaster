import 'package:shared_preferences/shared_preferences.dart';

// singleton class to insure that only one instance is created

class AppStorage {
  late final SharedPreferences _sharedPrefs;
  static final AppStorage _appStorageInstance = AppStorage._internal();

  factory AppStorage() => _appStorageInstance;
  AppStorage._internal();

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
