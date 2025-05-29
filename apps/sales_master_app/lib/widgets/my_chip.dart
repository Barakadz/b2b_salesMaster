import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class MyChip extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final double? borderRadius;

  const MyChip(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.textColor,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius:
              BorderRadius.circular(borderRadius ?? borderRadiusMedium)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: paddingXxs, horizontal: paddingXs),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(fontWeight: FontWeight.w500, color: textColor),
        ),
      ),
    );
  }
}
