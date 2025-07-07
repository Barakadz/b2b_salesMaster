import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_router/go_router.dart';

enum DrawerItemKey {
  dashboard,
  clients,
  pipeline,
}

class CustomDrawerController extends GetxController {
  var selectedItem = DrawerItemKey.dashboard.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void selectItem(DrawerItemKey item, BuildContext context) {
    selectedItem.value = item;
    switch (item) {
      case DrawerItemKey.dashboard:
        GoRouter.of(context).go('/realisations');
        break;
      case DrawerItemKey.clients:
        GoRouter.of(context).go('/myClients');
        break;
      case DrawerItemKey.pipeline:
        GoRouter.of(context).go('/Pipeline');
        break;
    }
  }

  // void openDrawer() {
  //   scaffoldKey.currentState?.openDrawer();
  // }

  void openDrawer(BuildContext context, {bool? baseview}) {
    print(baseview);
    if (baseview == true) {
      scaffoldKey.currentState?.openDrawer();
    } else {
      Scaffold.of(context).openDrawer();
    }
  }
}
