import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class InfoContainer extends StatelessWidget {
  final Icon? icon;
  final String label;
  final String content;
  final Widget? status;

  const InfoContainer(
      {super.key,
      this.icon,
      this.status,
      required this.label,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(borderRadiusSmall)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingS),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ?? SizedBox(),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: paddingXxs),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        0, paddingXs, paddingS, paddingXs),
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withValues(alpha: 0.15),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: paddingXxs,
            ),
            Text(
              content,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            status ?? SizedBox()
          ],
        ),
      ),
    );
  }
}
