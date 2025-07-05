import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_master_app/config/constants.dart';

class ProcessTab extends StatelessWidget {
  final VoidCallback? onTap;
  final String tabName;
  final bool clicked;
  final String svgPath;
  final Color? clickedbgColor;
  final Color? clickedBorderColor;
  final Color? clickedIconColor;
  final bool? subcategory;
  final bool? png;
  final EdgeInsetsGeometry? containerPadding;
  const ProcessTab(
      {super.key,
      this.onTap,
      this.clickedbgColor,
      this.clickedBorderColor,
      this.clickedIconColor,
      this.containerPadding,
      this.subcategory,
      this.png,
      required this.tabName,
      required this.clicked,
      required this.svgPath});

  @override
  Widget build(BuildContext context) {
    print(svgPath);
    return GestureDetector(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 110),
        child: Container(
            decoration: BoxDecoration(
                color: clicked
                    ? clickedbgColor ??
                        Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.04)
                    : Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: clicked
                        ? clickedBorderColor ??
                            Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline)),
            child: Padding(
              padding: containerPadding ??
                  const EdgeInsets.symmetric(
                      vertical: paddingM, horizontal: paddingXs),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  png == true
                      ? Image.asset(svgPath)
                      : SvgPicture.asset(
                          svgPath,
                          height: 23,
                          color: subcategory == true
                              ? null
                              : clicked
                                  ? clickedIconColor ??
                                      Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.primary,
                        ),
                  SizedBox(
                    height: paddingXs,
                  ),
                  Text(
                    tabName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 14,
                        fontWeight: clicked ? FontWeight.w700 : FontWeight.w600,
                        color: clicked
                            ? clickedIconColor ??
                                Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
