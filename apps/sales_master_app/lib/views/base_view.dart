import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/navigation_controller.dart';

class BaseView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final NavigationController navigationController =
      Get.put(NavigationController());
  BaseView({super.key, required this.navigationShell});

  Widget bottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Row(
        children: [],
      ),
    );
  }

  // Widget _getView(NavItem item) {
  //   switch (item) {
  //     case NavItem.clients:
  //       return ClientsScreen();
  //     case NavItem.pipeline:
  //       return PipelineMainPage();
  //     case NavItem.todolist:
  //       return TodolistScreen();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: navigationShell,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.outline,
                    offset: Offset(0, -4),
                    blurRadius: 14,
                    spreadRadius: 0,
                  ),
                ],
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavIcon(NavItem.clients, Icons.work_outline,
                      Icons.work_sharp, "Clients", context),
                  _buildNavIcon(NavItem.pipeline, Icons.timeline_outlined,
                      Icons.timeline_sharp, "Pipeline", context),
                  _buildNavIcon(NavItem.todolist, Icons.fact_check_outlined,
                      Icons.fact_check, "Todo", context),
                  // _buildNavIcon(NavItem.forms, Icons.folder_open_outlined,
                  //     Icons.folder_open, "Forms", context),
                  _buildNavIcon(NavItem.catalogue, Icons.redeem_outlined,
                      Icons.redeem_sharp, "Catalogue", context),
                  _buildNavIcon(NavItem.realisation, Icons.dashboard_outlined,
                      Icons.dashboard, "Board", context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(NavItem item, IconData outlined, IconData filledin,
      String title, BuildContext context) {
    return Obx(() {
      final isSelected = navigationController.selectedItem.value == item;
      return GestureDetector(
        onTap: () => navigationController.selectItem(item, navigationShell),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: paddingXs, vertical: paddingS),
          child: Column(
            spacing: paddingXxs,
            children: isSelected
                ? [
                    Icon(
                      filledin,
                      size: 22,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      title,
                      style: Theme.of(context)
                          .inputDecorationTheme
                          .hintStyle
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                    )
                  ]
                : [
                    Icon(
                      outlined,
                      size: 22,
                    ),
                    Text(
                      title,
                      style: Theme.of(context)
                          .inputDecorationTheme
                          .hintStyle
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                    )
                  ],
          ),
        ),
      );
    });
  }
}
