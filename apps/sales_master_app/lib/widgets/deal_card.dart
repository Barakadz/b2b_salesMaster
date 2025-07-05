import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class DealCard extends StatelessWidget {
  final String companyName;
  final String interlocuteur;
  final String number;
  final Widget? trailingWidget;

  const DealCard(
      {super.key,
      required this.companyName,
      required this.interlocuteur,
      required this.number,
      this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Theme.of(context).colorScheme.outline)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: paddingXs, horizontal: paddingS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  interlocuteur,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withValues(alpha: 0.5),
                      ),
                ),
                Text(
                  number,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withValues(alpha: 0.5),
                      ),
                )
              ],
            ),
            trailingWidget ?? SizedBox()
          ],
        ),
      ),
    );
  }
}
