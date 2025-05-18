import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class NotificationTab extends StatelessWidget {
  final String title;
  final bool clicked;
  const NotificationTab(
      {required this.title, required this.clicked, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: paddingM),
      child: Text(title,
          style: clicked == true
              ? Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600)
              : Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.25))),
    );
  }
}
