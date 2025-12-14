import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class DealCard extends StatelessWidget {
  final String companyName;
  final String interlocuteur;
  final String number;
  final Widget? trailingWidget;

  const DealCard({
    super.key,
    required this.companyName,
    required this.interlocuteur,
    required this.number,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust padding and font sizes based on screen width
    final double verticalPadding = screenWidth < 360 ? paddingXs / 2 : paddingXs;
    final double horizontalPadding = screenWidth < 360 ? paddingS / 2 : paddingS;
    final double fontSize = screenWidth < 360 ? 12 : 14;
    final double titleFontSize = screenWidth < 360 ? 14 : 16;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    companyName,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: titleFontSize),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    interlocuteur,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          fontSize: fontSize,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withOpacity(0.6),
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    number,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          fontSize: fontSize,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withOpacity(0.6),
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            trailingWidget ?? SizedBox(),
          ],
        ),
      ),
    );
  }
}
