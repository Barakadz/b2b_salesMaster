import 'package:intl/intl.dart';

class DateFormatterService {
  /// Format a date with optional locale.
  /// Example (en): "Tuesday 13th, Aug"
  /// Example (fr): "mardi 13, août"
  String format(DateTime date, {String locale = 'en'}) {
    final dayName = DateFormat('EEEE', locale).format(date);
    final month = DateFormat('MMM', locale).format(date);
    final day = date.day;

    if (locale == 'en') {
      return "$dayName ${day}${_getEnglishSuffix(day)}, $month";
    } else {
      // French (and most locales) don’t use suffixes
      return "$dayName $day, $month";
    }
  }

  /// Add ordinal suffix for English days (1st, 2nd, 3rd, 4th...)
  String _getEnglishSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "th";
    }
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }
}
