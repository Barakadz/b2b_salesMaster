import 'package:flutter/material.dart';

class StatusStyle {
  final Color backgroundColor;
  final Color textColor;

  const StatusStyle({
    required this.backgroundColor,
    required this.textColor,
  });
}

const Map<String, StatusStyle> statusStyles = {
  'prise de contact': StatusStyle(
    backgroundColor: Color(0X1ADCDEE3),
    textColor: Color(0XFFDCDEE3),
  ),
  "depot d'offre": StatusStyle(
    backgroundColor: Color(0X1A6AC8FF),
    textColor: Color(0xFF6AC8FF),
  ),
  'en cours': StatusStyle(
    backgroundColor: Color(0x1AFFD65C),
    textColor: Color(0xFFFFD65C),
  ),
  'conclusion': StatusStyle(
    backgroundColor: Color(0x1A53DAA0),
    textColor: Color(0xff53DAA0),
  ),
  'on hold': StatusStyle(
    backgroundColor: Color(0x1AF6405B),
    textColor: Color(0xffF6405B),
  )
};
