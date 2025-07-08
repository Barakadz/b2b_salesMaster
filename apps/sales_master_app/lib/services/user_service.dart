import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/user.dart';

class UsertService {
  Future<User?> getCurrentUser() async {
    try {
      final response = await Api.getInstance().get("user-info");
      if (response != null) {
        return User.fromJson(response.data["user"]);
      }
      return null;
    } catch (e) {
      print("Error fetching current user info: $e");
      return null;
    }
  }
}
