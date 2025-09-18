import 'package:flutter/widgets.dart';

/// a class that provide simple and customizable localizations/multi_language support for known server_errors/dio_errors
class RepoLocalizations {
  static Locale _locale = const Locale("en");
  static Map<String, Map<String, String>> _customMessages = {};

  /// set locale/language for the app, this should be called on app start and every time the user change the language
  /// Example usage:
  /// ```dart
  /// RepoLocalizations.setLocale(Locale("en"));
  /// ```
  static void setLocale(Locale locale) {
    _locale = locale;
  }

  /// translate string using current locale
  /// Example usage:
  /// ```dart
  /// RepoLocalizations.translate("connection_timeout");
  /// ```
  static String translate(String key) {
    if (_customMessages[_locale.languageCode]?.containsKey(key) ?? false) {
      return _customMessages[_locale.languageCode]![key]!;
    }

    final messages =
        _localizedMessages[_locale.languageCode] ?? _localizedMessages["en"]!;
    return messages[key] ?? key;
  }

  /// set custom error message translation
  /// Example usage:
  /// ```dart
  /// RepoLocalizations.setCustomErrorMessage({"en":{"not_found":"Resource Not Found"}});
  /// ```
  static void setCustomErrorMessage(Map<String, Map<String, String>> messages) {
    _customMessages = messages;
  }

  static final Map<String, Map<String, String>> _localizedMessages = {
    "en": {
      "request_cancelled": "Request to the server was cancelled.",
      "connection_timeout": "Connection timeout with the server.",
      "something_went_wrong": "Something went wrong. Please try again.",
      "bad_request": "Bad request. Please try again.",
      "unauthorized": "Unauthorized. Please log in again.",
      "forbidden": "Forbidden. You don’t have access.",
      "not_found": "Resource not found.",
      "server_error": "Server error. Please try again later.",
      "unexpected_response": "Unexpected server response."
    },
    "fr": {
      "request_cancelled": "La requête au serveur a été annulée.",
      "connection_timeout": "Délai de connexion dépassé avec le serveur.",
      "something_went_wrong": "Une erreur s'est produite. Veuillez réessayer.",
      "bad_request": "Mauvaise requête. Veuillez réessayer.",
      "unauthorized": "Non autorisé. Veuillez vous reconnecter.",
      "forbidden": "Accès refusé.",
      "not_found": "Ressource introuvable.",
      "server_error": "Erreur serveur. Veuillez réessayer plus tard.",
      "unexpected_response": "Réponse inattendue du serveur."
    },
  };
}
