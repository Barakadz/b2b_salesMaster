import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/drawer_controller.dart';
import 'package:sales_master_app/controllers/navigation_controller.dart';
import 'package:sales_master_app/widgets/custom_app_drawer.dart';

class BaseView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final NavigationController navigationController =
      Get.put(NavigationController());
  final CustomDrawerController drawerController =
      Get.find<CustomDrawerController>();

  BaseView({super.key, required this.navigationShell});

  Widget bottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Row(
        children: [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerController.scaffoldKey,
      drawer: CustomAppDrawer(
        onItemSelected: (DrawerItemKey item) {
          drawerController.selectedItem.value = item;

          switch (item) {
            case DrawerItemKey.home:
              navigationController.selectItem(NavItem.home, navigationShell);
              break;
            case DrawerItemKey.dashboard:
              GoRouter.of(context).go('/realisations');
              break;
            case DrawerItemKey.catalogue:
              GoRouter.of(context).go('/catalogue');
              break;
            // case DrawerItemKey.pipeline:
            //   GoRouter.of(context).go('/Pipeline');
            //   break;
          }
        },
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
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
                _buildNavIcon(NavItem.home, homeAsset, selectedHomeAsset,
                    "Home", context),
                _buildNavIcon(NavItem.clients, clientsAsset,
                    selectedClientsAsset, "Clients", context),
                _buildNavIcon(NavItem.pipeline, pipelineAsset,
                    selectedPipelineAsset, "Pipeline", context),
                _buildNavIcon(NavItem.todolist, todolistAsset,
                    selectedTodolistAsset, "Todo list", context),
                // _buildNavIcon(NavItem.catalogue, catalogueAsset,
                //     selectedCatalogueAsset, "Catalogue", context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNavIcon(NavItem item, String svgPath, String selectedSvgPath,
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
                    SvgPicture.asset(
                      selectedSvgPath,
                      //color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    Text(
                      title,
                      style: Theme.of(context)
                          .inputDecorationTheme
                          .hintStyle
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                    )
                  ]
                : [
                    SvgPicture.asset(
                      svgPath,
                      //color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    Text(
                      title,
                      style: Theme.of(context)
                          .inputDecorationTheme
                          .hintStyle
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 12),
                    )
                  ],
          ),
        ),
      );
    });
  }
}
