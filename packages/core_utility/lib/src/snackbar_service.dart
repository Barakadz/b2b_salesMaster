import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// a class that provide simple configurable snackbar widget to show errors or info on screen when needed
class SnackbarService {
  
  /// show snackbar that display error message aith error icon
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

  /// show snackbar that display a custom image with custom icon
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
