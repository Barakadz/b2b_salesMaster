import 'package:get/state_manager.dart';
import 'package:sales_master_app/models/user.dart';
import 'package:sales_master_app/services/user_service.dart';

class CurrentuserController extends GetxController {
  Rx<User?> currentUser = Rx<User?>(null);

  Future<void> loadCurrentUserInfo() async {
    User? user = await UsertService().getCurrentUser();
    if (user != null) {
      currentUser.value = user;
      currentUser.refresh();
    } else {
      // await Future.delayed(Duration(seconds: 2));
      // loadCurrentUserInfo();
    }
  }

  Future<void> loadFakeUser() async {
    currentUser.value = User(
        id: 3,
        firstName: "belkacem",
        lastName: "zamoun",
        employees: [],
        isSupervisor: false);
  }

  @override
  void onInit() {
    super.onInit();
    loadCurrentUserInfo();
  }
}
