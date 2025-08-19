import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/catalogues_options.dart';
import 'package:sales_master_app/models/coutry_model.dart';
import 'package:sales_master_app/models/file_model.dart';
import 'package:sales_master_app/models/roaming_model.dart';
import 'package:sales_master_app/services/catalogue_service.dart';
import 'package:sales_master_app/services/countries_service.dart';

class CatalogueController extends GetxController {
  Rx<int> mainTabdIndex = 0.obs;
  Rx<int> offersSubTabIndex = 0.obs;
  Rx<int> roamingTabIndex = 0.obs;
  TextEditingController searchBarTextController = TextEditingController();

  RxList<CatalogueOffer> catalogue = services.obs;

  RxList<CatalogueFile> files = <CatalogueFile>[].obs;

  Rx<CatalogueFile?> djezzyoffersFiles = Rx<CatalogueFile?>(null);
  Rx<CatalogueFile?> benchMarkFiles = Rx<CatalogueFile?>(null);
  Rx<CatalogueFile?> servicesFiles = Rx<CatalogueFile?>(null);
  Rx<CatalogueFile?> internationalFiles = Rx<CatalogueFile?>(null);

  RxBool loadingOffers = false.obs;
  RxBool errorOffers = false.obs;

  RxBool loadingBenchmark = false.obs;
  RxBool errorBenchmark = false.obs;

  RxBool loadingServices = false.obs;
  RxBool errorServices = false.obs;

  RxBool loadingFiles = true.obs;
  RxBool errorLoadingFile = false.obs;

  Rx<int?> clickedFileIndex = Rx<int?>(null);

  Rx<String> roamingType = "prepaid".obs;

  RxList<Country> countries = <Country>[].obs;
  RxList<Offer> offers =
      <Offer>[Offer(id: 1, name: "solution"), Offer(id: 2, name: "cloud")].obs;

  Rx<Offer?> selectedOffer = Rx<Offer?>(null);
  Rx<Country?> selectedCountry = Rx<Country?>(null);

  Rx<TarifRoaming?> roaming = Rx<TarifRoaming?>(null);
  RxBool loadingRoaming = false.obs;
  RxBool errorRoaming = false.obs;

  @override
  void onReady() {
    loadOffers();
    loadCountries();
    super.onReady();
  }

  void loadCountries() async {
    // countries.assignAll([
    //   Country(zone: 0, country: "france", cc: 23, countryCode: "FR"),
    //   Country(zone: 2, country: "spain", cc: 24, countryCode: "ESP"),
    // ]);
    List<Country> res = await CountryService().fetchCountries();
    countries.assignAll(res);
  }

  void loadRoaming(int zoneId) async {
    errorRoaming.value = false;
    loadingRoaming.value = true;
    roaming.value =
        await DocumentService().fetchTarifRoaming(zoneId, roamingType.value);

    // await Future.delayed(Duration(seconds: 2));
    // roaming.value = TarifRoaming(
    //     zone: 1,
    //     type: "postpaid",
    //     localCall: 10,
    //     callToAlgeria: 50,
    //     internationalCall: 100,
    //     receiveCall: 60,
    //     sms: 30,
    //     dataB2B: 3500,
    //     dataB2C: 4000);

    if (roaming.value == null) {
      errorLoadingFile.value = true;
    }
    loadingRoaming.value = false;
  }

  void switchRoamingType(String type) {
    roamingType.value = type;
    if (selectedCountry.value != null) {
      loadRoaming(selectedCountry.value!.zone);
    }
  }

  void switchMainTab(int index) {
    mainTabdIndex.value = index;
    clickedFileIndex.value = null;
    if (index == 0) {
      offersSubTabIndex.value = 0;
      loadOffers();
    }
  }

  void switchSubTab(int index) {
    offersSubTabIndex.value = index;
    if (index == 0) {
      loadOffers();
    } else {
      loadBenchmark();
    }
  }

  void changeOfferCategory(String name) {
    selectedOffer.value =
        offers.firstWhere((category) => category.name == name);
  }

  void changeCountry(String name) {
    selectedCountry.value =
        countries.firstWhere((category) => category.country == name);

    if (selectedCountry.value != null) {
      loadRoaming(selectedCountry.value!.zone);
    }
  }

  Future<void> loadFiles() async {
    clickedFileIndex.value = 10000;
    loadingFiles.value = true;
    errorLoadingFile.value = false;

    await Future.delayed(Duration(seconds: 3));
    files.assignAll([
      CatalogueFile(
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

  Future<void> loadOffers() async {
    errorOffers.value = false;
    loadingOffers.value = true;

    djezzyoffersFiles.value = await DocumentService().fetchOffersDocument();
    //await Future.delayed(Duration(seconds: 3));
    // djezzyoffersFiles.value = CatalogueFile(
    //     id: 1,
    //     name: "Offres Djezzy 2025",
    //     size: 94,
    //     uploadDate: "12/06/2025",
    //     unity: "KB",
    //     uploadedBy: "Imene Baya BETROUNI");

    loadingOffers.value = false;
  }

  Future<void> loadBenchmark() async {
    errorBenchmark.value = false;
    loadingBenchmark.value = true;

    benchMarkFiles.value = await DocumentService().fetchBenchMarkDocument();

    // await Future.delayed(Duration(seconds: 3));
    // benchMarkFiles.value = CatalogueFile(
    //     id: 1,
    //     name: "Offres Djezzy 2025",
    //     size: 94,
    //     uploadDate: "12/06/2025",
    //     unity: "KB",
    //     uploadedBy: "Imene Baya BETROUNI");

    loadingBenchmark.value = false;
  }

  Future<void> loadService() async {
    errorServices.value = false;
    loadingServices.value = true;

    servicesFiles.value = await DocumentService().fetchServiceDocuments();

    //await Future.delayed(Duration(seconds: 3));
    // servicesFiles.value = CatalogueFile(
    //     id: 1,
    //     name: "Offres Djezzy 2025",
    //     size: 94,
    //     uploadDate: "12/06/2025",
    //     unity: "KB",
    //     uploadedBy: "Imene Baya BETROUNI");

    loadingServices.value = false;
  }
}

// class Country {
//   int id;
//   String code;
//   String name;

//   Country({required this.id, required this.code, required this.name});
// }

class Offer {
  int id;
  String name;

  Offer({required this.id, required this.name});
}
