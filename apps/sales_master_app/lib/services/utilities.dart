import 'package:sales_master_app/config/app_config.dart';

bool isEmpty(String? text) {
  if (text == null || text.replaceAll(" ", "").isEmpty) {
    return true;
  }
  return false;
}

/// Format msisdn: remove leading 0 if present, prepend 213
String formatMsisdn(String msisdn) {
  final s = msisdn.trim();
  if (s.startsWith('213')) return s;
  final cleaned = s.startsWith('0') ? s.substring(1) : s;
  return '213$cleaned';
}

String userScopedBaseUrl(String msisdnRaw) {
  final msisdn = formatMsisdn(msisdnRaw);
  return '${AppConfig.authHost}/api/v1/$msisdn';
}
