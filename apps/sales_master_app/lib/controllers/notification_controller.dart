import 'package:get/get.dart';
import 'package:sales_master_app/models/notification.dart';

class NotificationController extends GetxController {
  Rx<int> tabIndex = 0.obs;
  RxList<AppNotification> todaysNotifications = <AppNotification>[].obs;
  RxList<AppNotification> oldNotifications = <AppNotification>[].obs;

  void setTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    getNotification();
    super.onInit();
  }

  void getNotification() {
    // call api
    // set today notif  and older notif
    //fake data
    todaysNotifications.value = [
      AppNotification(
          title: "Pending Task",
          content:
              "simply dummy text of the printing and typesetting industry. Lorem Ipsum",
          date: DateTime.now(),
          type: "reminder"),
      AppNotification(
          title: "Pending Task",
          content:
              "simply dummy text of the printing and typesetting industry. Lorem Ipsum",
          date: DateTime.now(),
          type: "reminder"),
      AppNotification(
          title: "Outlook",
          content:
              "long established fact that a reader will be distracted by the readable content of a page",
          date: DateTime.now(),
          type: "outlook"),
      AppNotification(
          title: "Meeting at 10:00",
          content:
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form",
          date: DateTime.now(),
          type: "meeting")
    ];
    todaysNotifications.refresh();

    oldNotifications.value = [
      AppNotification(
          title: "Pending Task",
          content:
              "simply dummy text of the printing and typesetting industry. Lorem Ipsum",
          date: DateTime.now().subtract(Duration(days: 3)),
          type: "reminder"),
      AppNotification(
          title: "Pending Task",
          content:
              "simply dummy text of the printing and typesetting industry. Lorem Ipsum",
          date: DateTime.now().subtract(Duration(days: 5)),
          type: "reminder"),
      AppNotification(
          title: "Outlook",
          content:
              "long established fact that a reader will be distracted by the readable content of a page",
          date: DateTime.now().subtract(Duration(days: 6)),
          type: "outlook"),
      AppNotification(
          title: "Meeting at 11:00",
          content:
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form",
          date: DateTime.now().subtract(Duration(days: 1)),
          type: "meeting")
    ];
    oldNotifications.refresh();
  }
}
