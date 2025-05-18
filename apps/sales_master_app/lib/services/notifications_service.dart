import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/notification.dart';

class NotificationsService {
  Future<Map<String, dynamic>?> getAllNotifications() async {
    final response = await Api.getInstance().get("api/notifications/");
    if (response != null) {
      List<AppNotification> todaysNotifications = [];
      List<AppNotification> oldNotifications = [];
      //this will change later when the api is ready
      try {
        todaysNotifications = response.data["todaysNotifications"]
            .map<AppNotification>(
                (jsonObject) => AppNotification.fromJson(jsonObject))
            .toList();

        return {
          "todaysNotifications": todaysNotifications,
          "oldNotifications": oldNotifications
        };
      } catch (e) {
        print("failed to parse notifications");
        rethrow;
      }
    }
    return null;
  }
}
