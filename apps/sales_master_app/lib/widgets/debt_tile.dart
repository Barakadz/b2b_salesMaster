import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class DebtTile extends StatelessWidget {
  final String label;
  final String content;
  final Widget? prefix;

  const DebtTile(
      {super.key, required this.label, required this.content, this.prefix});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        prefix ??
            Icon(
              Icons.circle,
              size: 14,
              color: Colors.red,
            ),
        SizedBox(
          width: paddingXs,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.25)),
        ),
        Spacer(),
        Text(
          content,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }
}
