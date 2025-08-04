import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/deal_status_style.dart';
import 'package:sales_master_app/models/deal.dart';
import 'package:sales_master_app/models/deal_status.dart';
import 'package:sales_master_app/services/deals_service.dart';

class DealsController extends GetxController {
  Rx<bool> loadingDeals = false.obs;
  Rx<bool> errorLoadingDeals = false.obs;
  //RxList<Deal> deals = <Deal>[].obs;
  Rx<PaginatedDeals?> paginatedDeals = Rx<PaginatedDeals?>(null);

  TextEditingController dealSearchController = TextEditingController();

  RxList<String> dealsStatusFilters =
      statusStyles.keys.map((key) => key).toList().obs;

  RxString selectedDealFilter = statusStyles.keys.first.obs;

  List<DealStatus> dealsStatus = [
    DealStatus(id: 0, name: "prise de contact"),
    DealStatus(id: 1, name: "depot d'offre"),
    DealStatus(id: 2, name: "en cours"),
    DealStatus(id: 3, name: "conclusion"),
    DealStatus(id: 5, name: "on hold")
  ];

  Timer? _dealsDebounce;

  @override
  void onInit() {
    super.onInit();
    loadFakeDeals();
    dealSearchController.addListener(() {
      if (_dealsDebounce?.isActive ?? false) _dealsDebounce?.cancel();

      _dealsDebounce = Timer(const Duration(milliseconds: 700), () {
        //loadDeals();
        loadFakeDeals();
      });
    });
  }

  void filterDeals(String filter) {
    selectedDealFilter.value = filter;
    loadFakeDeals();
    //loadDeals();
  }

  Future<void> loadFakeDeals() async {
    loadingDeals.value = true;
    errorLoadingDeals.value = false;

    await Future.delayed(Duration(seconds: 3));
    paginatedDeals.value =
        PaginatedDeals(currentPage: 1, lastPage: 1, perPage: 50, deals: [
      Deal(
          id: 1,
          raisonSociale: "cevitale",
          interlocuteur: "mohammed amine",
          numero: "0798654321",
          visitDate: "10/02/2025",
          nextVisittDate: "15/06/2025",
          status: "conclusion",
          mom: ""),
      Deal(
          id: 2,
          raisonSociale: "air algerie",
          interlocuteur: "anis amir",
          numero: "0798654321",
          visitDate: "10/02/2025",
          nextVisittDate: "15/06/2025",
          status: "en cours",
          mom: ""),
      Deal(
          id: 3,
          raisonSociale: "yassir",
          interlocuteur: "yacine omar",
          numero: "0798654321",
          visitDate: "10/02/2025",
          nextVisittDate: "15/06/2025",
          status: "on hold",
          mom: ""),
      Deal(
          id: 4,
          raisonSociale: "cevitale",
          interlocuteur: "mohammed amine",
          numero: "0798654321",
          visitDate: "10/02/2025",
          nextVisittDate: "15/06/2025",
          status: "on hold",
          mom: ""),
    ]);
    // deals.assignAll([
    //   Deal(
    //       id: 1,
    //       raisonSociale: "cevitale",
    //       interlocuteur: "mohammed amine",
    //       numero: "0798654321",
    //       visitDate: "10/02/2025",
    //       nextVisittDate: "15/06/2025",
    //       status: "conclusion",
    //       mom: ""),
    //   Deal(
    //       id: 2,
    //       raisonSociale: "air algerie",
    //       interlocuteur: "anis amir",
    //       numero: "0798654321",
    //       visitDate: "10/02/2025",
    //       nextVisittDate: "15/06/2025",
    //       status: "en cours",
    //       mom: ""),
    //   Deal(
    //       id: 3,
    //       raisonSociale: "yassir",
    //       interlocuteur: "yacine omar",
    //       numero: "0798654321",
    //       visitDate: "10/02/2025",
    //       nextVisittDate: "15/06/2025",
    //       status: "on hold",
    //       mom: ""),
    //   Deal(
    //       id: 4,
    //       raisonSociale: "cevitale",
    //       interlocuteur: "mohammed amine",
    //       numero: "0798654321",
    //       visitDate: "10/02/2025",
    //       nextVisittDate: "15/06/2025",
    //       status: "on hold",
    //       mom: ""),
    // ]);

    loadingDeals.value = false;
    errorLoadingDeals.value = false;
    print(paginatedDeals.value?.deals.length);
  }

  Future<void> loadDeals() async {
    loadingDeals.value = true;
    errorLoadingDeals.value = false;

    final PaginatedDeals? result =
        await DealsService().getAllDeals(dealSearchController.text);

    if (result == null) {
      errorLoadingDeals.value = true;
    } else {
      paginatedDeals.value = result;
    }
    loadingDeals.value = false;
  }
}
