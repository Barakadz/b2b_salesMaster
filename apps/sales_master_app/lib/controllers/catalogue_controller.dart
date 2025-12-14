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

  // Changed from Rx<CatalogueFile?> to RxList<CatalogueFile>
  RxList<CatalogueFile> djezzyoffersFiles = <CatalogueFile>[].obs;
  RxList<CatalogueFile> benchMarkFiles = <CatalogueFile>[].obs;
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
  RxList<CountryInternational> countriesInternational =
      <CountryInternational>[].obs;

  RxList<Offer> offers =
      <Offer>[Offer(id: 1, name: "solution"), Offer(id: 2, name: "cloud")].obs;

  Rx<Offer?> selectedOffer = Rx<Offer?>(null);
  Rx<Country?> selectedCountry = Rx<Country?>(null);
  Rx<CountryInternational?> selectedCountryInternational =
      Rx<CountryInternational?>(null);

  Rx<TarifRoaming?> roaming = Rx<TarifRoaming?>(null);
  RxBool loadingRoaming = false.obs;
  RxBool errorRoaming = false.obs;

  RxList<TarifInternational> internationalList = <TarifInternational>[].obs;

  RxString selectedTechnology = "fix".obs;

  RxBool loadingInternational = false.obs;
  RxBool errorInternational = false.obs;
  @override
  void onReady() {
    loadOffers();
    loadCountries();
    loadCountriesInternational();

    super.onReady();
  }

  List<String> get availableTechnologies {
    return internationalList
        .map((e) => e.technology)
        .toSet() // remove duplicates
        .toList();
  }

  void loadCountries() async {
    List<Country> res = await CountryService().fetchCountries();
    countries.assignAll(res);
  }

  void loadRoaming(int zoneId) async {
    errorRoaming.value = false;
    loadingRoaming.value = true;
    roaming.value =
        await DocumentService().fetchTarifRoaming(zoneId, roamingType.value);

    if (roaming.value == null) {
      errorLoadingFile.value = true;
    }
    loadingRoaming.value = false;
  }

  void loadCountriesInternational() async {
    List<CountryInternational> res =
        await CountryService().fetchCountriesInternational();
    countriesInternational.assignAll(res);
  }

  void loadInternational(String pays) async {
    errorInternational.value = false;
    loadingInternational.value = true;

    internationalList.value =
        await DocumentService().fetchTarifInternational(pays);

    if (internationalList.isNotEmpty) {
      selectedTechnology.value = internationalList.first.technology;
    } else {
      errorInternational.value = true;
    }

    loadingInternational.value = false;
  }

  void changeCountryInternational(String name) {
    final country =
        countriesInternational.firstWhereOrNull((c) => c.country == name);

    selectedCountryInternational.value = country;

    if (country != null) {
      loadInternational(name);
    }
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
    } else if (index == 1 && countries.isEmpty) {
      loadCountries();
    }
  }

  void switchSubTab(int index) {
    offersSubTabIndex.value = index;
    clickedFileIndex.value = null; // Reset selection when switching tabs
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
          uploadedBy: "Imene Baya BETROUNI",
          filePath: "")
    ]);
    files.refresh();
    loadingFiles.value = false;
    errorLoadingFile.value = false;
  }

  Future<void> loadOffers() async {
    errorOffers.value = false;
    loadingOffers.value = true;

    List<CatalogueFile> offersList =
        await DocumentService().fetchOffersDocuments();
    djezzyoffersFiles.assignAll(offersList);

    loadingOffers.value = false;
  }

  Future<void> loadBenchmark() async {
    errorBenchmark.value = false;
    loadingBenchmark.value = true;

    List<CatalogueFile> benchmarkList =
        await DocumentService().fetchBenchMarkDocuments();
    benchMarkFiles.assignAll(benchmarkList);

    loadingBenchmark.value = false;
  }

  Future<void> loadService() async {
    errorServices.value = false;
    loadingServices.value = true;

    servicesFiles.value = await DocumentService().fetchServiceDocuments();

    loadingServices.value = false;
  }
}

class Offer {
  int id;
  String name;

  Offer({required this.id, required this.name});
}
