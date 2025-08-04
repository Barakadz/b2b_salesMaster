import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class NotificationService {
  static void showSuccess(BuildContext context, String title, ThemeData theme,
      [String? description]) {
    _show(context, title, description, ToastificationType.success, theme);
  }

  static void showError(BuildContext context, String title, ThemeData theme,
      [String? description]) {
    _show(context, title, description, ToastificationType.error, theme);
  }

  static void showInfo(BuildContext context, String title, ThemeData theme,
      [String? description]) {
    _show(context, title, description, ToastificationType.info, theme);
  }

  static void showWarning(BuildContext context, String title, ThemeData theme,
      [String? description]) {
    _show(context, title, description, ToastificationType.warning, theme);
  }

  static void _show(
    BuildContext context,
    String title,
    String? description,
    ToastificationType type,
    ThemeData theme,
  ) {
    final colorScheme = theme.colorScheme;
    print(colorScheme.outlineVariant.toString());

    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      title: Text(title, style: theme.textTheme.titleSmall),
      description: description != null
          ? Text(description, style: theme.textTheme.bodySmall)
          : null,
      autoCloseDuration: const Duration(seconds: 5),
      animationDuration: const Duration(milliseconds: 300),
      direction: TextDirection.ltr,
      alignment: Alignment.topRight,
      backgroundColor: colorScheme.outlineVariant,
      foregroundColor: colorScheme.outlineVariant,
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
