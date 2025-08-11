import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

enum NavItem {
  //clients,
  //pipeline,
  home,
  clients,
  pipeline,
  todolist,
  // forms,
  //catalogue,
  //realisation
}

class NavigationController extends GetxController {
  var selectedItem = NavItem.home.obs;

  void selectItem(NavItem item, StatefulNavigationShell navigationShell) {
    selectedItem.value = item;
    navigationShell.goBranch(item.index);
  }
}
