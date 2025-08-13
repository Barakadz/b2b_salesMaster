import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class CustomTab extends StatelessWidget {
  final bool isActive;
  final String title;
  final VoidCallback ontap;

  const CustomTab(
      {super.key,
      required this.isActive,
      required this.title,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isActive == true
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.05)
                : Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withValues(alpha: 0.03)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: paddingXs, horizontal: paddingXxl),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isActive == true
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.25)),
          ),
        ),
      ),
    );
  }
}
