import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_master_app/config/constants.dart';

class InboxWidget extends StatelessWidget {
  const InboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/inbox.svg",
          width: 18,
        ),
        SizedBox(
          width: paddingXxs,
        ),
        Text(
          "Inbox",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.5),
              fontWeight: FontWeight.w500,
              fontSize: 12),
        )
      ],
    );
  }
}
