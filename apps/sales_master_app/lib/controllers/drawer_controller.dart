import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

enum DrawerItemKey {
  home,
  dashboard,
  //clients,
  //pipeline,
  catalogue
}

class CustomDrawerController extends GetxController {
var selectedItem = Rxn<DrawerItemKey>(); // nullable

  // Each controller instance gets its own unique scaffold key
  late final GlobalKey<ScaffoldState> scaffoldKey;

  CustomDrawerController() {
    scaffoldKey = GlobalKey<ScaffoldState>();
  }
void selectItem(DrawerItemKey item, BuildContext context) {
  selectedItem.value = item;

  switch (item) {
    case DrawerItemKey.home:
      GoRouter.of(context).push('/homepage');
      break;

    case DrawerItemKey.dashboard:
      GoRouter.of(context).push('/realisations');
      break;

    case DrawerItemKey.catalogue:
      GoRouter.of(context).push('/catalogue');
      break;
  }
}
  
void updateSelectedItemByRoute(BuildContext context) {
  final String current = GoRouterState.of(context).matchedLocation;

  if (current.startsWith('/homepage')) {
    selectedItem.value = DrawerItemKey.home;
  } else if (current.startsWith('/realisations')) {
    selectedItem.value = DrawerItemKey.dashboard;
  } else if (current.startsWith('/catalogue')) {
    selectedItem.value = DrawerItemKey.catalogue;
  } else {
    // 🔥 No match → deselect
    selectedItem.value = null;
  }
}

  void openDrawer(BuildContext context, {bool? baseview}) {
    if (baseview == true) {
      scaffoldKey.currentState?.openDrawer();
    } else {
      Scaffold.of(context).openDrawer();
    }
  }
}

// class CustomDrawerController extends GetxController {
//   var selectedItem = DrawerItemKey.dashboard.obs;
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   void selectItem(DrawerItemKey item, BuildContext context) {
//     selectedItem.value = item;
//     switch (item) {
//       case DrawerItemKey.home:
//         GoRouter.of(context).go('/homepage');
//         break;
//       case DrawerItemKey.dashboard:
//         GoRouter.of(context).go('/realisations');
//         break;
//       case DrawerItemKey.catalogue:
//         GoRouter.of(context).go('/catalogue');
//         break;
//       // case DrawerItemKey.pipeline:
//       //   GoRouter.of(context).go('/Pipeline');
//       //   break;
//     }
//   }

//   // void openDrawer() {
//   //   scaffoldKey.currentState?.openDrawer();
//   // }

//   void openDrawer(BuildContext context, {bool? baseview}) {
//     print(baseview);
//     if (baseview == true) {
//       scaffoldKey.currentState?.openDrawer();
//     } else {
//       Scaffold.of(context).openDrawer();
//     }
//   }
// }
