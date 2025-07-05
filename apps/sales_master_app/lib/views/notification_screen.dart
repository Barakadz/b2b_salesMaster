import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/notification_controller.dart';
import 'package:sales_master_app/models/notification.dart';
import 'package:sales_master_app/widgets/notification_card.dart';
import 'package:sales_master_app/widgets/notification_tab.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController =
        Get.put(NotificationController());

    int notificationsCount = 1 +
        notificationController.todaysNotifications.length +
        1 +
        notificationController.oldNotifications.length;
    List<AppNotification> todaysNotifications =
        notificationController.todaysNotifications;
    List<AppNotification> oldNotifications =
        notificationController.oldNotifications;

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
                    AppLocalizations.of(context)!.notifications_page_title,
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(onTap: () {
                    notificationController.setTabIndex(0);
                  }, child: Obx(() {
                    return NotificationTab(
                        title: AppLocalizations.of(context)!.all_notifications,
                        clicked: notificationController.tabIndex.value == 0);
                  })),
                  GestureDetector(onTap: () {
                    notificationController.setTabIndex(1);
                  }, child: Obx(() {
                    return NotificationTab(
                        title:
                            AppLocalizations.of(context)!.outlook_notifications,
                        clicked: notificationController.tabIndex.value == 1);
                  })),
                  GestureDetector(onTap: () {
                    notificationController.setTabIndex(2);
                  }, child: Obx(() {
                    return NotificationTab(
                        title:
                            AppLocalizations.of(context)!.unread_notifications,
                        clicked: notificationController.tabIndex.value == 2);
                  }))
                ],
              ),
            ),
            SizedBox(height: paddingM),
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
                child: ListView.builder(
                    itemCount: notificationsCount,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: paddingS),
                          child: Text(
                            AppLocalizations.of(context)!.today,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant
                                        .withOpacity(0.25)),
                          ),
                        );
                      } else if (index <= todaysNotifications.length) {
                        return Obx(() {
                          return NotificationCard(
                              notification: todaysNotifications[index - 1]);
                        });
                      } else if (index == todaysNotifications.length + 1) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: paddingS),
                            child: Text(
                              AppLocalizations.of(context)!.older,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant
                                          .withOpacity(0.25)),
                            ),
                          ),
                        );
                      } else {
                        return Obx(() {
                          final notif = oldNotifications[
                              index - todaysNotifications.length - 2];
                          return NotificationCard(notification: notif);
                        });
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
