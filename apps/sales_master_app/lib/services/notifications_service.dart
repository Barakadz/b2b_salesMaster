import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/notification.dart';

class NotificationsService {
  Future<PaginatedNotifications?> getAllNotifications(
      {bool unread = true}) async {
    try {
      Map<String, dynamic> queryParameters = {"unread": unread};

      final response = await Api.getInstance()
          .get("notification", queryParameters: queryParameters);

      if (response != null && response.data?["success"] == true) {
        final data = response.data;
        return PaginatedNotifications.fromJson(data);
      }

      print("Failed to get notificationss");
      return null;
    } catch (e, stacktrace) {
      print("Exception while fetching notifications: $e\n$stacktrace");
      return null;
    }
  }

  Future<bool> readNotifications(String id) async {
    try {
      final response =
          await Api.getInstance().post("notification/$id/mark-as-read");

      if (response != null && response.data?["success"] == true) {
        return true;
      }

      return false;
    } catch (e, stacktrace) {
      print("Exception : $e\n$stacktrace");
      return false;
    }
  }
}
