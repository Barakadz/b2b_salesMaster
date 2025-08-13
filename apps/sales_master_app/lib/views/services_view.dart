import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/controllers/catalogue_controller.dart';
import 'package:sales_master_app/widgets/empty_widget.dart';
import 'package:sales_master_app/widgets/error_widget.dart';
import 'package:sales_master_app/widgets/file_card.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';

class ServiceView extends StatelessWidget {
  const ServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    CatalogueController catalogueController = Get.find();
    return Obx(() {
      return catalogueController.loadingServices.value == true
          ? Center(child: LoadingIndicator())
          : catalogueController.errorOffers.value == true
              ? CustomErrorWidget()
              : catalogueController.servicesFiles.value == null
                  ? EmptyWidget()
                  : GestureDetector(
                      onTap: () {
                        print(catalogueController.servicesFiles.value!.id);
                        if (catalogueController.clickedFileIndex.value !=
                            catalogueController.servicesFiles.value!.id) {
                          catalogueController.clickedFileIndex.value =
                              catalogueController.servicesFiles.value!.id;
                        } else {
                          catalogueController.clickedFileIndex.value = null;
                        }
                      },
                      child: Obx(() {
                        return FileCard(
                          file: catalogueController.servicesFiles.value!,
                          clicked: catalogueController.clickedFileIndex.value ==
                              catalogueController.servicesFiles.value!.id,
                          png: true,
                        );
                      }),
                    );
    });
  }
}
