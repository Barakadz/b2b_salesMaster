import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
 import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/notification_controller.dart';
import 'package:sales_master_app/models/notification.dart';
import 'package:sales_master_app/widgets/error_widget.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';
import 'package:sales_master_app/widgets/notification_card.dart';
import 'package:sales_master_app/widgets/notification_tab.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController =
        Get.put(NotificationController());

    // int notificationsCount = 1 +
    //     notificationController.todaysNotifications.length +
    //     1 +
    //     notificationController.oldNotifications.length;
    // List<AppNotification> todaysNotifications =
    //     notificationController.todaysNotifications;
    // List<AppNotification> oldNotifications =
    //     notificationController.oldNotifications;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: paddingM,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingXl),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "notifications_page_title".tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: paddingL,
            ),
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: paddingXl),
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        GestureDetector(
          onTap: () => notificationController.setTabIndex(0),
          child: Obx(() {
            return NotificationTab(
              title: "new_notifications".tr,
              clicked: notificationController.tabIndex.value == 0,
            );
          }),
        ),
        SizedBox(width: 12),
        GestureDetector(
          onTap: () => notificationController.setTabIndex(2),
          child: Obx(() {
            return NotificationTab(
              title: "read_notifications".tr,
              clicked: notificationController.tabIndex.value == 2,
            );
          }),
        ),
      ],
    ),
  ),
)
,
            SizedBox(height: paddingS),
            Divider(
              thickness: 1,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withOpacity(0.10),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: paddingXl),
                child: Obx(() {
                  return notificationController.loadingNotification.value ==
                          true
                      ? SizedBox(
                          height: 200,
                          width: 200,
                          child: Center(child: LoadingIndicator()),
                        )
                      : notificationController.notificationError.value == true
                          ? CustomErrorWidget(
                              onTap: () {
                                notificationController.getNotification();
                              },
                            )
                          : ListView.builder(
                              itemCount:
                                  notificationController.notifications.length,
                              itemBuilder: (context, index) {
                                AppNotification notification =
                                    notificationController.notifications[index];

                                return GestureDetector(
                                    onTap: () {
                                      if (notification.route != null) {
                                        context.go(notification.route!);
                                        notificationController
                                            .markAsRead(notification.id);
                                      }
                                    },
                                    child: NotificationCard(
                                        notification: notification));
                                // if (index == 0) {
                                //   return Padding(
                                //     padding: const EdgeInsets.only(bottom: paddingS),
                                //     child: Text(
                                //       "today".tr,
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .titleSmall
                                //           ?.copyWith(
                                //               fontSize: 13,
                                //               fontWeight: FontWeight.w400,
                                //               color: Theme.of(context)
                                //                   .colorScheme
                                //                   .onSurfaceVariant
                                //                   .withOpacity(0.25)),
                                //     ),
                                //   );
                                // } else if (index <= todaysNotifications.length) {
                                //   return Obx(() {
                                //     return NotificationCard(
                                //         notification: todaysNotifications[index - 1]);
                                //   });
                                // } else if (index == todaysNotifications.length + 1) {
                                //   return Padding(
                                //     padding: const EdgeInsets.only(top: 16.0),
                                //     child: Padding(
                                //       padding: const EdgeInsets.only(bottom: paddingS),
                                //       child: Text(
                                //         "older".tr,
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .titleSmall
                                //             ?.copyWith(
                                //                 fontSize: 13,
                                //                 fontWeight: FontWeight.w400,
                                //                 color: Theme.of(context)
                                //                     .colorScheme
                                //                     .onSurfaceVariant
                                //                     .withOpacity(0.25)),
                                //       ),
                                //     ),
                                //   );
                                // } else {
                                //   return Obx(() {
                                //     final notif = oldNotifications[
                                //         index - todaysNotifications.length - 2];
                                //     return NotificationCard(notification: notif);
                                //   });
                                // }
                              });
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
