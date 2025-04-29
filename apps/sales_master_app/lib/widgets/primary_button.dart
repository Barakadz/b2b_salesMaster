import 'package:flutter/material.dart';
import 'package:sales_master_app/constants.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Widget? child;
  final double? height;

  const PrimaryButton(
      {super.key,
      required this.onTap,
      required this.text,
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onTap,
        child: child ??
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
      ),
    );
  }
}
