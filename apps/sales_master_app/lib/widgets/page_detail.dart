import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_master_app/config/constants.dart';

class PageDetail extends StatelessWidget {
  final String title;
  final Color? bgColor;

  const PageDetail({super.key, required this.title, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor ?? Theme.of(context).colorScheme.surface,
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withValues(alpha: 0.05)))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: paddingS, horizontal: 26),
        child: Row(
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
            // Icon(
            //   Icons.notifications_outlined,
            //   size: paddingL,
            //   color: Theme.of(context).colorScheme.onSurfaceVariant,
            // )
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                color: Theme.of(context).colorScheme.onPrimary,
                "assets/notification_bell.svg",
                height: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
