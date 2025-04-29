import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_master_app/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final void Function(String?)? onchanged;
  final List<TextInputFormatter>? textFormaters;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prifixIcon;
  final bool? filled;
  final Color? fillColor;
  final double? radius;
  final int? maxLength;
  final TextAlign? textAlign;
  final Color? outlineColor;
  final String? countrerText;
  final EdgeInsetsGeometry? innerPadding;

  const CustomTextFormField(
      {super.key,
      this.labelText,
      this.hintText,
      this.countrerText,
      this.controller,
      this.keyboardType,
      this.innerPadding,
      this.obscureText = false,
      this.maxLines = 1,
      this.validator,
      this.readOnly = false,
      this.initialValue,
      this.textFormaters,
      this.suffixIcon,
      this.outlineColor,
      this.prifixIcon,
      this.filled,
      this.onTap,
      this.fillColor,
      this.radius,
      this.textAlign,
      this.maxLength,
      this.onchanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      validator: validator,
      style: Theme.of(context).textTheme.bodySmall,
      readOnly: readOnly,
      onTap: onTap,
      initialValue: initialValue,
      inputFormatters: textFormaters,
      onChanged: onchanged,
      maxLength: maxLength,
      textAlign: textAlign ?? TextAlign.left,
      decoration: InputDecoration(
        contentPadding: innerPadding ?? const EdgeInsets.all(paddingXm),
        counterText: countrerText ?? "",
        suffixIcon: suffixIcon,
        prefixIcon: prifixIcon,
        labelText: labelText,
        hintText: hintText,
        filled: filled,
        fillColor: fillColor ?? Theme.of(context).colorScheme.surface,
        labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? borderRadius),
          borderSide: BorderSide(
              color: outlineColor ?? Theme.of(context).colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? borderRadius),
          borderSide: BorderSide(
              color: outlineColor ?? Theme.of(context).colorScheme.outline),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
