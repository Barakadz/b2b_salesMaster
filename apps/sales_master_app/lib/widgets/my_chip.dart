import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class MyChip extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final double? borderRadius;
  final Widget? prefixWidget;
  final bool? showBorders;
  final double? horizontalPadding;

  const MyChip(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.textColor,
      this.showBorders,
      this.horizontalPadding,
      this.prefixWidget,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
              color: showBorders == true ? textColor : Colors.transparent),
          borderRadius:
              BorderRadius.circular(borderRadius ?? borderRadiusMedium)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: paddingXxs, horizontal: paddingXs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            prefixWidget != null
                ? Padding(
                    padding: const EdgeInsets.only(right: paddingXxs),
                    child: prefixWidget,
                  )
                : SizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0),
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontWeight: FontWeight.w500, color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
