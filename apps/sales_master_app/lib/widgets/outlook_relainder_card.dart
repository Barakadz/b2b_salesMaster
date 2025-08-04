import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/models/outlook_reminder.dart';

class OutlookRemainderCard extends StatelessWidget {
  final int? index;
  final int? count;
  final OutlookReminder reminder;
  const OutlookRemainderCard(
      {super.key, required this.reminder, this.index, this.count});

  Widget dateTimeContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .onSurfaceVariant
              .withValues(alpha: 0.03),
          border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.06)),
          borderRadius: BorderRadius.circular(3)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: paddingXxs, horizontal: paddingXs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0XFFFFAD49)),
            ),
            SizedBox(
              width: paddingXs,
            ),
            Text(
              "${reminder.date}, ${reminder.startTime} - ${reminder.endTime}",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withValues(alpha: 0.5)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          color: Theme.of(context).colorScheme.outlineVariant,
          border: Border.all(
              color: Theme.of(context).colorScheme.tertiaryContainer)),
      child: Padding(
        padding: const EdgeInsets.all(paddingS),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //header
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: paddingS,
              children: [
                //Icon
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withValues(alpha: 0.05)),
                  child: Center(
                    child: Icon(
                      Icons.campaign_outlined,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 18,
                    ),
                  ),
                ),
                Text(
                  "Reminder",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              height: paddingL,
            ),
            //title
            Text(
              reminder.subject,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            //location
            Text(
              reminder.location,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withValues(alpha: 0.25)),
            ),
            SizedBox(
              height: paddingS,
            ),

            //time and count
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                dateTimeContainer(context),
                Spacer(),
                index != null && count != null
                    ? Text(
                        "$index of $count",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withValues(alpha: 0.25)),
                      )
                    : SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}
