import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class Note extends StatelessWidget {
  final Color? bgColor;
  final Color? borderColor;
  final IconData? icon;
  final String info;

  const Note(
      {super.key,
      this.bgColor,
      this.borderColor,
      this.icon,
      required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusSmall),
          color: bgColor ?? Color(0xffF0C43F).withValues(alpha: 0.10),
          border: Border.all(color: borderColor ?? Color(0xffF0C43F))),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: paddingM, vertical: paddingS),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon ?? Icons.info_outlined,
              color: borderColor ?? Color(0xffF0C43F),
            ),
            SizedBox(
              width: paddingM,
            ),
            Expanded(
              child: Text(
                info,
                overflow: TextOverflow.clip,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: borderColor ?? Color(0xffF0C43F)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
