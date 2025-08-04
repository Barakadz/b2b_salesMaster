import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart';

///class to get app info like buildNUmber and version name , you should addpubspec.yaml to the assets section first
class AppInfo {
  static String defaultVersion = "0.0.0+0";
  static Future<String> getAppInfo() async {
    try {
      // Load pubspec.yaml from assets
      final String yamlString = await rootBundle.loadString('pubspec.yaml');
      final dynamic parsedYaml = loadYaml(yamlString);

      final String version = parsedYaml['version'] ?? defaultVersion;

      return version;
    } catch (e) {
      return defaultVersion;
    }
  }

  ///get the version number that comes befor the + in app version
  static Future<String> getVersionName() async {
    return (await getAppInfo()).split("+")[0];
  }

  ///get number that comes after + in app verison
  static Future<int> getBuildNumber() async {
    try {
      String buildNumber = (await getAppInfo()).split("+")[1];
      return int.parse(buildNumber);
    } catch (e) {
      return 0;
    }
  }
}
