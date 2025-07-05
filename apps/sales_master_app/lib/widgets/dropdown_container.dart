import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class DropdownContainer extends StatelessWidget {
  //final Icon? icon;
  final Widget? prefixIcon;
  final String label;
  final Widget dropdown;

  const DropdownContainer(
      {super.key,
      this.prefixIcon,
      required this.label,
      required this.dropdown});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
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
            prefixIcon ?? SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingXxs),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        right:
                            BorderSide(color: Theme.of(context).dividerColor))),
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
            SizedBox(
              width: paddingXxs,
            ),
            Expanded(child: dropdown),
          ],
        ),
      ),
    );
  }
}
