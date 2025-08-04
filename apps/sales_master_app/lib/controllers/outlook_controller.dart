import 'package:get/get.dart';
import 'package:sales_master_app/models/outlook_reminder.dart';

class OutlookController extends GetxController {
  RxList<OutlookReminder> reminders = <OutlookReminder>[].obs;
  RxBool loadingOutlook = false.obs;
  RxBool outlookError = false.obs;

  RxInt tabIndex = 0.obs;

  List<String> tabs = ["Today", "Last Week", "Last Month"];

  @override
  void onInit() {
    fetchReminders();
    super.onInit();
  }

  Future<void> fetchReminders() async {
    loadingOutlook.value = true;
    outlookError.value = false;
    await Future.delayed(Duration(seconds: 3));
    reminders.assignAll([
      OutlookReminder(
          subject: "b2b sales master app",
          location: "B8_E1_2_Meeting_Room",
          date: "10/01/2025",
          startTime: "9:00",
          endTime: "10:00"),
      OutlookReminder(
          subject: "b2b people app",
          location: "B6_E3_2_Meeting_Room",
          date: "16/01/2025",
          startTime: "10:00",
          endTime: "10:30")
    ]);

    loadingOutlook.value = false;
    outlookError.value = false;
  }

  void switchTab(int index) {
    if (index != tabIndex.value) {
      fetchReminders();
    }
    tabIndex.value = index;
  }
}
