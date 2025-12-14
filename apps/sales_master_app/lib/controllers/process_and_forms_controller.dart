import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/models/file_model.dart';

class ProcessAndFormsController extends GetxController {
  Rx<int> selectedTab = 0.obs;
  List<CatalogueFile> formsFiles = <CatalogueFile>[].obs;
  List<CatalogueFile> processFiles = <CatalogueFile>[].obs;

  Rx<bool> loadingForms = false.obs;
  Rx<bool> loadingProcess = false.obs;

  Rx<bool> errorLoadingForms = false.obs;
  Rx<bool> errorLoadingProcess = false.obs;

  TextEditingController fileSearchController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    loadProcessFiles();
  }

  void switchTabIndex(int index) {
    selectedTab.value = index;
    if (index == 0) {
      loadProcessFiles();
    } else {
      loadFormsFiles();
    }
  }

  void loadFormsFiles() async {
    loadingForms.value = true;
    errorLoadingForms.value = false;

    await Future.delayed(Duration(seconds: 3));

    // formsFiles.assignAll([
    //   CatalogueFile(
    //       id: 0,
    //       name: "Formulaire N01",
    //       size: 94,
    //       uploadDate: "12/06/2025",
    //       unity: "kb",
    //       uploadedBy: "Imene Baya BETROUNI"),
    //   CatalogueFile(
    //       id: 1,
    //       name: "Formulaire N02",
    //       size: 94,
    //       uploadDate: "12/06/2025",
    //       unity: "kb",
    //       uploadedBy: "Imene Baya BETROUNI"),
    //   CatalogueFile(
    //       id: 2,
    //       name: "Formulaire N03",
    //       size: 94,
    //       uploadDate: "12/06/2025",
    //       unity: "kb",
    //       uploadedBy: "Imene Baya BETROUNI")
    // ]);
    loadingForms.value = false;
    errorLoadingForms.value = false;
  }

  void loadProcessFiles() async {
    loadingProcess.value = true;
    errorLoadingProcess.value = false;

    await Future.delayed(Duration(seconds: 3));

    // processFiles.assignAll([
    //   CatalogueFile(
    //       id: 0,
    //       name: "Process N01",
    //       size: 94,
    //       uploadDate: "12/06/2025",
    //       unity: "kb",
    //       uploadedBy: "Imene Baya BETROUNI"),
    //   CatalogueFile(
    //       id: 1,
    //       name: "Process N02",
    //       size: 94,
    //       uploadDate: "12/06/2025",
    //       unity: "kb",
    //       uploadedBy: "Imene Baya BETROUNI"),
    //   CatalogueFile(
    //       id: 2,
    //       name: "Process N03",
    //       size: 94,
    //       uploadDate: "12/06/2025",
    //       unity: "kb",
    //       uploadedBy: "Imene Baya BETROUNI")
    // ]);
    loadingProcess.value = false;
    errorLoadingProcess.value = false;
  }
}
