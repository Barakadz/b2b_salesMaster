import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/catalogues_options.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/catalogue_controller.dart';
import 'package:sales_master_app/views/international_tarif_view.dart';
import 'package:sales_master_app/views/offers_view.dart';
import 'package:sales_master_app/views/roaming_view.dart';
import 'package:sales_master_app/views/services_view.dart';
import 'package:sales_master_app/widgets/custom_app_drawer.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/primary_button.dart';
import 'package:sales_master_app/widgets/process_tab.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CatalogueController catalogueController = Get.put(CatalogueController());
    List<Widget> views = [
      OffersView(),
      // ServiceView(),
      RoamingView(),
      InternationalTarifView()
    ];
    return Scaffold(
      drawer: CustomAppDrawer(),
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PageDetail(
            baseviewpage: false,
            //title: "mon_portfeuille".tr,
            title: "Catalogues d’offres",
            bgColor: Theme.of(context).colorScheme.outlineVariant,
          ),
          SizedBox(
            height: paddingS,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingL, vertical: paddingXs),
              child: Text(
                "Mon Catalogue",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // catalogueController.mainTabdsIndex.value == 0 ||
          //         catalogueController.mainTabdsIndex.value == 1
          //     ? Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: paddingL),
          //         child: CustomTextFormField(
          //           login: false,
          //           filled: true,
          //           fillColor: Theme.of(context).colorScheme.primaryContainer,
          //           hintText: "Search by file name",
          //           controller: catalogueController.searchBarTextController,
          //           prifixIcon: Icon(
          //             Icons.search,
          //             color: Theme.of(context).colorScheme.outline,
          //           ),
          //         ),
          //       )
          //     : SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: paddingM, horizontal: paddingL),
            child: Container(
              height: 100,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: catalogueController.catalogue.length,
                  itemBuilder: (context, index) {
                    print(services.length);
                    CatalogueOffer tab = catalogueController.catalogue[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: paddingXs),
                      child: Obx(() {
                        return ProcessTab(
                          onTap: () {
                            catalogueController.switchMainTab(tab.index);
                            print("clicked");
                            print(tab.index);
                          },
                          clickedbgColor: Theme.of(context).colorScheme.primary,
                          clickedBorderColor:
                              Theme.of(context).colorScheme.primary,
                          clickedIconColor:
                              Theme.of(context).colorScheme.onPrimary,
                          tabName: tab.name,
                          //svgPath: tab.svgPath,
                          svgPath: tab.svgPath,
                          clicked:
                              catalogueController.mainTabdIndex == tab.index,
                        );
                      }),
                    );
                  },
                );
              }),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingL, vertical: paddingS),
              child: SingleChildScrollView(child: Obx(() {
                return views[catalogueController.mainTabdIndex.value];
              })),
            ),
          ),
          Obx(() {
            return catalogueController.clickedFileIndex.value != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: paddingL),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: paddingS),
                      child: PrimaryButton(onTap: () {}, text: "Download"),
                    ),
                  )
                : SizedBox();
          })
        ],
      )),
    );
  }
}
