import 'package:flutter/material.dart';
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
  var selectedItem = Rxn<NavItem>();

  static const Map<NavItem, String> _branchRoots = {
    NavItem.home: '/homepage',
    NavItem.clients: '/myClients',
    NavItem.pipeline: '/Pipeline',
    NavItem.todolist: '/todolist',
  };

  void syncWithShell(StatefulNavigationShell shell, BuildContext context) {
    final location = GoRouter.of(context).state.uri.toString(); 

    // Vérifie si la route actuelle correspond à une branche
    for (final entry in _branchRoots.entries) {
      if (location.startsWith(entry.value)) {
        selectedItem.value = entry.key;
        return;
      }
    }

    selectedItem.value = null; // route hors menu  aucune sélection
  }
 void selectItem(NavItem item, BuildContext context) {
  selectedItem.value = item;

  final path = _branchRoots[item];
  if (path != null) {
    GoRouter.of(context).push(path);
  }
}

}

 