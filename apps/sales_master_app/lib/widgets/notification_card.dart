import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/models/notification.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notification;
  const NotificationCard({
    required this.notification,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: paddingM),
      child: Container(
        height: 43,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // pic / icon
            SvgPicture.asset(
              //notificationAssets[notification.type],
              'assets/alert_notification.svg',
              height: 39,
              width: 39,
            ),
            SizedBox(
              width: paddingS,
            ),
            //data
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // title and date
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          notification.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontSize: 14),
                        ),
                      ),
                      Text(
                        notification.createdAt.toString().substring(0, 10),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(
                    height: paddingXxs,
                  ),
                  // description
                  Text(
                    notification.message,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
