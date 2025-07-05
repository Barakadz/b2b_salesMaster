import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_master_app/config/constants.dart';

class SalaryNote extends StatelessWidget {
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final String? prefixSvgPath;
  final String? suffixSvgPath;
  final String? title;
  final double raise;
  const SalaryNote(
      {super.key,
      this.bgColor,
      this.textColor,
      this.borderColor,
      this.prefixSvgPath,
      this.title,
      this.raise = 0,
      this.suffixSvgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor ?? Color(0xffF0C43F).withValues(alpha: 0.10),
          border: Border.all(color: borderColor ?? Color(0xffF0C43F))),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: paddingM, vertical: paddingS),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: paddingXxs,
              children: [
                prefixSvgPath != null
                    ? SvgPicture.asset(
                        prefixSvgPath!,
                        height: 20,
                        color: textColor ?? Color(0XffFFAD49),
                      )
                    : SizedBox(),
                Text(
                  title ?? "Bravo",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: textColor ?? Color(0XffFFAD49), fontSize: 16),
                ),
                suffixSvgPath != null
                    ? SvgPicture.asset(suffixSvgPath!,
                        height: 20, color: textColor ?? Color(0XffFFAD49))
                    : SizedBox(),
              ],
            ),
            // SizedBox(
            //   height: paddingXxs,
            // ),
            Text(
              "Vous avez +$raise de votre Salair de base",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: textColor ?? Color(0XffFFAD49)),
            )
          ],
        ),
      ),
    );
  }
}
