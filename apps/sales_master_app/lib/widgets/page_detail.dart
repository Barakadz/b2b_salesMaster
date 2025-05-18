import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class PageDetail extends StatelessWidget {
  final String title;

  const PageDetail({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.menu_outlined,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          size: paddingL,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        Icon(
          Icons.notifications_outlined,
          size: paddingL,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        )
      ],
    );
  }
}
