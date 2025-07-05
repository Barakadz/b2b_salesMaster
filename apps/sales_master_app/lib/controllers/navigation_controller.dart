import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

enum NavItem {
  clients,
  pipeline,
  todolist,
  // forms,
  catalogue,
  realisation
}

class NavigationController extends GetxController {
  var selectedItem = NavItem.clients.obs;

  void selectItem(NavItem item, StatefulNavigationShell navigationShell) {
    selectedItem.value = item;
    navigationShell.goBranch(item.index);
  }
}
