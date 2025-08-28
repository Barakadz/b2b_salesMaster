import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/outlook_reminder.dart';

class CalendarService {
  Future<List<OutlookReminder>?> getCalendarReminders(
      String startDate, String endDate) async {
    try {
      Map<String, dynamic> queryParameters = {
        "start_date": startDate,
        "end_date": endDate,
      };

      final response = await Api.getInstance()
          .get("calendar", queryParameters: queryParameters);

      if (response != null && response.data?["success"] == true) {
        print("got response ${response.data}");
        final data = response.data?["data"] as List;
        return data.map((item) => OutlookReminder.fromJson(item)).toList();
      }

      print(
          "Failed to get calendar reminders: response was null or unsuccessful");
      return null;
    } catch (e, stacktrace) {
      print("Exception while fetching calendar reminders: $e\n$stacktrace");
      return null;
    }
  }
}
