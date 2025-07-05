import 'package:flutter/rendering.dart';

class RealisationCategoryStyle {
  final Color categoryColor;

  const RealisationCategoryStyle({required this.categoryColor});
}

const Map<String, RealisationCategoryStyle> realisationCategoryStyles = {
  "GA": RealisationCategoryStyle(categoryColor: Color(0xff9D53FF)),
  "Net Adds": RealisationCategoryStyle(categoryColor: Color(0xff53DAA0)),
  "Solutions": RealisationCategoryStyle(categoryColor: Color(0xff499EFF)),
  "New Compte": RealisationCategoryStyle(categoryColor: Color(0xffFDDB34)),
  "Empty": RealisationCategoryStyle(categoryColor: Color(0x1A767680)),
  "Evaluation": RealisationCategoryStyle(categoryColor: Color(0xffFFAD49))
};
