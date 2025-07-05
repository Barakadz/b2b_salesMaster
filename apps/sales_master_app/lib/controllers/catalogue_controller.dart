import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/catalogues_options.dart';
import 'package:sales_master_app/models/file_model.dart';

class CatalogueController extends GetxController {
  Rx<int> mainTabdsIndex = 0.obs;
  Rx<int> subTabdsIndex = 0.obs;
  TextEditingController searchBarTextController = TextEditingController();

  RxList<CatalogueOffer> catalogue = services.obs;

  RxList<UploadedFile> files = <UploadedFile>[].obs;
  RxBool loadingFiles = true.obs;
  RxBool errorLoadingFile = false.obs;

  Rx<int> clickedFileIndex = 10000.obs;

  RxList<Country> countries = <Country>[].obs;
  RxList<Offer> offers =
      <Offer>[Offer(id: 1, name: "solution"), Offer(id: 2, name: "cloud")].obs;

  Rx<Offer?> selectedOffer = Rx<Offer?>(null);
  Rx<Country?> selectedCountry = Rx<Country?>(null);

  @override
  void onReady() {
    loadFiles();
    loadCountries();
    super.onReady();
  }

  void loadCountries() {
    print("loading countries");
    countries.assignAll([
      Country(id: 0, name: "france", code: "fr"),
      Country(id: 2, name: "spain", code: "esp"),
    ]);
    countries.refresh();
  }

  void switchMainTab(int index) {
    mainTabdsIndex.value = index;
    loadFiles();
  }

  void switchSubTab(int index) {
    subTabdsIndex.value = index;
    loadFiles();
  }

  void changeOfferCategory(String name) {
    selectedOffer.value =
        offers.firstWhere((category) => category.name == name);
  }

  void changeCountry(String name) {
    selectedCountry.value =
        countries.firstWhere((category) => category.name == name);
  }

  Future<void> loadFiles() async {
    clickedFileIndex.value = 10000;
    loadingFiles.value = true;
    errorLoadingFile.value = false;

    await Future.delayed(Duration(seconds: 3));
    files.assignAll([
      UploadedFile(
          id: 1,
          name: "Offres Djezzy 2025",
          size: 94,
          uploadDate: "12/06/2025",
          unity: "KB",
          uploadedBy: "Imene Baya BETROUNI")
    ]);
    files.refresh();
    loadingFiles.value = false;
    errorLoadingFile.value = false;
  }
}

class Country {
  int id;
  String code;
  String name;

  Country({required this.id, required this.code, required this.name});
}

class Offer {
  int id;
  String name;

  Offer({required this.id, required this.name});
}
