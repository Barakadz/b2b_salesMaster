import 'package:flutter/services.dart';

// class DateInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     var text = newValue.text.replaceAll('-', '');

//     final buffer = StringBuffer();
//     for (int i = 0; i < text.length; i++) {
//       if (i == 2 || i == 4) {
//         buffer.write('-');
//       }
//       buffer.write(text[i]);
//     }

//     final newText = buffer.toString();
//     return TextEditingValue(
//       text: newText,
//       selection: TextSelection.collapsed(offset: newText.length),
//     );
//   }
// }

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length == 4 || text.length == 7) {
      if (!text.endsWith('-')) {
        text += '-';
      }
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
