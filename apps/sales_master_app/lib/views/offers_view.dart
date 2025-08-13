import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/catalogue_controller.dart';
import 'package:sales_master_app/widgets/custom_tab.dart';
import 'package:sales_master_app/widgets/empty_widget.dart';
import 'package:sales_master_app/widgets/error_widget.dart';
import 'package:sales_master_app/widgets/file_card.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    CatalogueController catalogueController = Get.find();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: paddingS,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: paddingS,
          children: [
            Obx(() {
              return CustomTab(
                  isActive: catalogueController.offersSubTabIndex.value == 0,
                  title: "Offres",
                  ontap: () {
                    catalogueController.switchSubTab(0);
                  });
            }),
            Obx(() {
              return CustomTab(
                  isActive: catalogueController.offersSubTabIndex.value == 1,
                  title: "Benchmark",
                  ontap: () {
                    catalogueController.switchSubTab(1);
                  });
            }),
          ],
        ),
        Obx(() {
          return catalogueController.offersSubTabIndex.value == 0
              ? (catalogueController.loadingOffers.value == true
                  ? Center(child: LoadingIndicator())
                  : catalogueController.errorOffers.value == true
                      ? CustomErrorWidget()
                      : catalogueController.djezzyoffersFiles.value == null
                          ? EmptyWidget()
                          : GestureDetector(
                              onTap: () {
                                print(catalogueController
                                    .djezzyoffersFiles.value!.id);
                                if (catalogueController
                                        .clickedFileIndex.value !=
                                    catalogueController
                                        .djezzyoffersFiles.value?.id) {
                                  catalogueController.clickedFileIndex.value =
                                      catalogueController
                                          .djezzyoffersFiles.value?.id;
                                } else {
                                  catalogueController.clickedFileIndex.value =
                                      null;
                                }
                              },
                              child: Obx(() {
                                return FileCard(
                                  file: catalogueController
                                      .djezzyoffersFiles.value!,
                                  clicked: catalogueController
                                          .clickedFileIndex.value ==
                                      catalogueController
                                          .djezzyoffersFiles.value!.id,
                                  png: true,
                                );
                              }),
                            ))
              : (catalogueController.loadingBenchmark.value == true
                  ? Center(child: LoadingIndicator())
                  : catalogueController.errorBenchmark.value == true
                      ? CustomErrorWidget()
                      : catalogueController.benchMarkFiles.value == null
                          ? EmptyWidget()
                          : GestureDetector(
                              onTap: () {
                                print(catalogueController
                                    .benchMarkFiles.value!.id);
                                if (catalogueController
                                        .clickedFileIndex.value !=
                                    catalogueController
                                        .benchMarkFiles.value?.id) {
                                  catalogueController.clickedFileIndex.value =
                                      catalogueController
                                          .benchMarkFiles.value?.id;
                                } else {
                                  catalogueController.clickedFileIndex.value =
                                      null;
                                }
                              },
                              child: Obx(() {
                                return FileCard(
                                  file:
                                      catalogueController.benchMarkFiles.value!,
                                  clicked: catalogueController
                                          .clickedFileIndex.value ==
                                      catalogueController
                                          .benchMarkFiles.value!.id,
                                  png: true,
                                );
                              }),
                            ));
        }),
      ],
    );
  }
}
