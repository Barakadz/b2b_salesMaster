import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_master_app/models/outlook_reminder.dart';
import 'package:sales_master_app/services/outlook_service.dart';

class OutlookController extends GetxController {
  RxList<OutlookReminder> reminders = <OutlookReminder>[].obs;
  RxBool loadingOutlook = false.obs;
  RxBool outlookError = false.obs;

  RxInt tabIndex = 0.obs;

  List<String> tabs = ["Today", "This Week", "This Month"];

  @override
  void onInit() {
    fetchReminders();
    super.onInit();
  }

  Future<void> fetchReminders() async {
    loadingOutlook.value = true;
    outlookError.value = false;

    final now = DateTime.now();
    late DateTime start;
    late DateTime end;

    if (tabIndex.value == 0) {
      // Today
      start = DateTime(now.year, now.month, now.day, 0, 0, 0);
      end = DateTime(now.year, now.month, now.day, 23, 59, 59);
    } else if (tabIndex.value == 1) {
      // This Week (Mon → Sun)
      final weekday = now.weekday;
      start = now.subtract(Duration(days: weekday - 1)); // Monday
      start = DateTime(start.year, start.month, start.day, 0, 0, 0);
      end = start
          .add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
    } else {
      // This Month
      start = DateTime(now.year, now.month, 1, 0, 0, 0);
      end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    }

    final formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
    String startStr = formatter.format(start);
    String endStr = formatter.format(end);

    List<OutlookReminder>? res =
        await CalendarService().getCalendarReminders(startStr, endStr);

    if (res == null) {
      outlookError.value = true;
      print("error loading reminders");
    } else {
      reminders.assignAll(res);
    }

    loadingOutlook.value = false;
  }

  void switchTab(int index) {
    if (index != tabIndex.value) {
      tabIndex.value = index;
      fetchReminders();
    }
  }
}
