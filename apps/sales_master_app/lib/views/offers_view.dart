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
  final String title;

  const OffersView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    CatalogueController catalogueController = Get.find();

    // Automatically set the selected tab based on title
    if (title == "Offres" && catalogueController.offersSubTabIndex.value != 0) {
      catalogueController.offersSubTabIndex.value = 0;
    } else if (title == "Benchmark" && catalogueController.offersSubTabIndex.value != 1) {
      catalogueController.offersSubTabIndex.value = 1;
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: paddingS,
      children: [
       
        Obx(() {
          return catalogueController.offersSubTabIndex.value == 0
              ? _buildOffersList(catalogueController)
              : _buildBenchmarkList(catalogueController);
        }),
      ],
    );
  }

  Widget _buildOffersList(CatalogueController controller) {
    if (controller.loadingOffers.value) {
      return Center(child: LoadingIndicator());
    }
    
    if (controller.errorOffers.value) {
      return CustomErrorWidget();
    }
    
    if (controller.djezzyoffersFiles.isEmpty) {
      return EmptyWidget();
    }

    return Column(
      children: List.generate(
        controller.djezzyoffersFiles.length,
        (index) {
          final file = controller.djezzyoffersFiles[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: paddingS),
            child: GestureDetector(
              onTap: () {
                if (controller.clickedFileIndex.value != index) {
                  controller.clickedFileIndex.value = index;
                } else {
                  controller.clickedFileIndex.value = null;
                }
              },
              child: Obx(() {
                return FileCard(
                  file: file,
                  clicked: controller.clickedFileIndex.value == index,
                  png: true,
                );
              }),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBenchmarkList(CatalogueController controller) {
    if (controller.loadingBenchmark.value) {
      return Center(child: LoadingIndicator());
    }
    
    if (controller.errorBenchmark.value) {
      return CustomErrorWidget();
    }
    
    if (controller.benchMarkFiles.isEmpty) {
      return EmptyWidget();
    }

    return Column(
      children: List.generate(
        controller.benchMarkFiles.length,
        (index) {
          final file = controller.benchMarkFiles[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: paddingS),
            child: GestureDetector(
              onTap: () {
                if (controller.clickedFileIndex.value != index) {
                  controller.clickedFileIndex.value = index;
                } else {
                  controller.clickedFileIndex.value = null;
                }
              },
              child: Obx(() {
                return FileCard(
                  file: file,
                  clicked: controller.clickedFileIndex.value == index,
                  png: true,
                );
              }),
            ),
          );
        },
      ),
    );
  }
}