import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  static void showError(
    {required String errorMessage,
      bool isDismissible = true,
      Duration duration = const Duration(seconds:4),
      iconColor = Colors.red
    }) {
    Get.showSnackbar(
      GetSnackBar(
        title: "Error",
        message: errorMessage,
        isDismissible: isDismissible,
        duration: duration,
        icon: Icon(Icons.error_sharp, color: iconColor),
      ),
    );
  }

  static void showCustomMessage({
    required String message,
    required String title,
    bool isDismissible = true,
    Duration duration = const Duration(seconds:4),
    Widget? decorationWidget

  }){
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        isDismissible: isDismissible,
        duration: duration,
        icon: decorationWidget,
      ),
    );
  }
}
