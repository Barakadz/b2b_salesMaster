import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_master_app/config/constants.dart';

class EmptyWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? icon;
  const EmptyWidget({super.key, this.title, this.description, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(paddingXxs),
      child: Container(
        constraints: BoxConstraints(maxWidth: 330),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ??
                SvgPicture.asset(
                  "assets/empty.svg",
                  height: 40,
                ),
            SizedBox(
              height: paddingS,
            ),
            Text(
              title ?? "No Data",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withValues(alpha: 0.5)),
            ),
            SizedBox(
              height: paddingXxs,
            ),
            Text(
              description ?? "There is currently no data in this section",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withValues(alpha: 0.5)),
            )
          ],
        ),
      ),
    );
  }
}
