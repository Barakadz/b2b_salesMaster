import 'package:country_flags/country_flags.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/drawer_controller.dart';
import 'package:sales_master_app/controllers/translation_controller.dart';
import 'package:sales_master_app/widgets/primary_button.dart';

class CustomAppDrawer extends StatelessWidget {
  final CustomDrawerController drawerController =
      Get.find<CustomDrawerController>();
  final TranslationController translationController =
      Get.put(TranslationController());

  final Map<DrawerItemKey, (String, String)> drawerItems = {
    DrawerItemKey.dashboard: (dashboardAsset, "Dashboard Realisations"),
    DrawerItemKey.clients: (clientsAsset, "Portefeuille client"),
    DrawerItemKey.pipeline: (pipelineAsset, "Pipeline"),
  };
  CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: paddingM, vertical: paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Language Selector
              Row(
                children: [
                  // DropdownButton<String>(
                  //   value: "Français",
                  //   items: ["Français", "English"]
                  //       .map((lang) =>
                  //           DropdownMenuItem(value: lang, child: Text(lang)))
                  //       .toList(),
                  //   onChanged: (value) {
                  //     // Handle language switch
                  //   },
                  // )
                  Center(
                    child: IntrinsicWidth(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: paddingXs),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingXs),
                              child: Text(
                                'language',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                          items: translationController.languages
                              .map((Language item) => DropdownMenuItem<String>(
                                    value: item.name,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: paddingXs),
                                      child: Row(
                                        children: [
                                          CountryFlag.fromCountryCode(
                                            item.code,
                                            shape: Rectangle(),
                                            width: 26,
                                            height: 18,
                                          ),
                                          SizedBox(
                                            width: paddingS,
                                          ),
                                          Text(
                                            item.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value:
                              translationController.selectedLanguage.value.name,
                          onChanged: (String? name) {
                            if (name != null) {
                              translationController.setLanguage(name);
                            }
                          },
                          buttonStyleData: ButtonStyleData(
                            elevation: 0,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer)),
                            padding: const EdgeInsets.only(left: 0, right: 8),
                            height: 57,
                            width: double.infinity,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 35,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: paddingXl),

              // pages
              ...drawerItems.entries.map((entry) {
                return Obx(() => _buildDrawerItem(
                      context,
                      key: entry.key,
                      svgPath: entry.value.$1,
                      title: entry.value.$2,
                      selected:
                          drawerController.selectedItem.value == entry.key,
                      onTap: () =>
                          drawerController.selectItem(entry.key, context),
                    ));
              }),
              const Spacer(),
              PrimaryButton(
                onTap: () {
                  // Navigator.of(context).pop();
                  // Get.find<AuthController>().logout();
                  // GoRouter.of(context).go('/login');
                },
                height: 40,
                text: "Log out",
                prefixIcon: SvgPicture.asset(logoutAsset),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required DrawerItemKey key,
    required String svgPath,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
        Navigator.pop(context); // Close drawer
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: paddingXxs),
        padding: const EdgeInsets.all(paddingXs),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.03)
              : null,
          border: selected
              ? Border.all(color: Theme.of(context).colorScheme.primary)
              : null,
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              // width: 22,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: selected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
