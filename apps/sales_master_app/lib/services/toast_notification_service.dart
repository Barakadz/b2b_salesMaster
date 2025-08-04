import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastNotificationService {
  static void showSuccess(
      BuildContext context, String title, Color backgroundColor,
      [String? description]) {
    _show(context, title, description, backgroundColor,
        ToastificationType.success);
  }

  static void showError(
      BuildContext context, String title, Color backgroundColor,
      [String? description]) {
    _show(
        context, title, description, backgroundColor, ToastificationType.error);
  }

  static void showInfo(
      BuildContext context, String title, Color backgroundColor,
      [String? description]) {
    _show(
        context, title, description, backgroundColor, ToastificationType.info);
  }

  static void showWarning(BuildContext context, String title,
      Color backgroundColor, ThemeData theme,
      [String? description]) {
    _show(context, title, description, backgroundColor,
        ToastificationType.warning);
  }

  static void _show(BuildContext context, String title, String? description,
      Color backgroundColor, ToastificationType type) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      description: description != null
          ? Text(
              description,
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,
      autoCloseDuration: const Duration(seconds: 5),
      animationDuration: const Duration(milliseconds: 300),
      direction: TextDirection.ltr,
      alignment: Alignment.topRight,
      backgroundColor: backgroundColor,
      foregroundColor: backgroundColor,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
      //borderRadius: BorderRadius.circular(12),
      //padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      //margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      // boxShadow: const [
      //   BoxShadow(
      //     color: Color(0x07000000),
      //     blurRadius: 16,
      //     offset: Offset(0, 16),
      //   )
      // ],
      // showProgressBar: true,
      showIcon: true,
      // closeOnClick: false,
      // pauseOnHover: true,
      // dragToClose: true,
      // applyBlurEffect: true,
    );
  }
}
