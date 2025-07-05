import 'package:flutter/material.dart';

class TodolistStatusStyle {
  final Color backgroundColor;
  final Color textColor;

  const TodolistStatusStyle({
    required this.backgroundColor,
    required this.textColor,
  });
}

const Map<String, TodolistStatusStyle> todolistStatusStyle = {
  "Low": TodolistStatusStyle(
      backgroundColor: Color(0x1A6AC8FF), textColor: Color(0xFF6AC8FF)),
  "Medium": TodolistStatusStyle(
      backgroundColor: Color(0x1AF0C43F), textColor: Color(0xffF0C43F)),
  "High": TodolistStatusStyle(
      backgroundColor: Color(0x1AEF2B48), textColor: Color(0xffEF2B48)),
  "Done": TodolistStatusStyle(
      backgroundColor: Color(0x1A31BB6A), textColor: Color(0xff31BB6A)),
};
