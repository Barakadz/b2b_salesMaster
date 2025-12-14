import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/catalogues_options.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/catalogue_controller.dart';
import 'package:sales_master_app/services/catalogue_service.dart';
import 'package:sales_master_app/views/international_tarif_view.dart';
import 'package:sales_master_app/views/offers_view.dart';
import 'package:sales_master_app/views/roaming_view.dart';
import 'package:sales_master_app/widgets/custom_app_drawer.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/primary_button.dart';
import 'package:sales_master_app/widgets/process_tab.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CatalogueController catalogueController = Get.put(CatalogueController());
    List<Widget> views = [
      OffersView(title: "Offres",),
      OffersView(title: "Benchmark",),
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
              title: "catalogue_offre".tr,
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
                  "Mon Catalogue".tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
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
                      CatalogueOffer tab = catalogueController.catalogue[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: paddingXs),
                        child: Obx(() {
                          return ProcessTab(
                            onTap: () {
                              catalogueController.switchMainTab(tab.index);
                                  catalogueController.switchSubTab(tab.index);
                              print(tab.index);
                            },
                            clickedbgColor: Theme.of(context).colorScheme.primary,
                            clickedBorderColor:
                                Theme.of(context).colorScheme.primary,
                            clickedIconColor:
                                Theme.of(context).colorScheme.onPrimary,
                            tabName: tab.name,
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
                child: SingleChildScrollView(
                  child: Obx(() {
                    return views[catalogueController.mainTabdIndex.value];
                  })
                ),
              ),
            ),
            Obx(() {
              return catalogueController.clickedFileIndex.value != null
                  ? catalogueController.offersSubTabIndex.value == 0 || 
                    catalogueController.offersSubTabIndex.value == 1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: paddingL),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: paddingS),
                            child: PrimaryButton(
                              onTap: () async {
                                final selectedIndex = catalogueController.clickedFileIndex.value;
                                
                                // Get the correct files list based on current tab
                                final filesList = catalogueController.offersSubTabIndex.value == 0
                                    ? catalogueController.djezzyoffersFiles
                                    : catalogueController.benchMarkFiles;
                                
                                if (selectedIndex != null && selectedIndex < filesList.length) {
                                  final selectedFile = filesList[selectedIndex];
                                  
                                  String getFileExtension(String path) {
                                    if (path.contains('.')) {
                                      return '.${path.split('.').last}';
                                    }
                                    return '';
                                  }
                                  
                                  final ext = getFileExtension(selectedFile.filePath ?? '');
                                  
                                  await DocumentService().downloadAndOpenFile(
                                    '${selectedFile.name}$ext',
                                    selectedFile.id,
                                  );
                                } else {
                                  print("No file selected");
                                }
                              },
                              text: "Download".tr
                            ),
                          ),
                        )
                      : SizedBox() 
                  : SizedBox();
            })
          ],
        )
      ),
    );
  }
}