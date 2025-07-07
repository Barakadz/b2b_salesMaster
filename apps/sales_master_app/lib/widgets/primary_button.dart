import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Widget? child;
  final double? height;
  final Widget? prefixIcon;

  const PrimaryButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.prefixIcon,
      this.child,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? primaryButtonHeight,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            //shadowColor: Theme.of(context).colorScheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: paddingXs),
              child: child ?? prefixIcon ?? SizedBox(),
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
