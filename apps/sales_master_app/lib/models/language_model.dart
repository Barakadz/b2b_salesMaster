import 'package:flutter/material.dart';

class Language {
  String name;
  String code;
  String language_code;
  Locale locale;

  Language(
      {required this.name,
      required this.code,
      required this.language_code,
      required this.locale});
}
