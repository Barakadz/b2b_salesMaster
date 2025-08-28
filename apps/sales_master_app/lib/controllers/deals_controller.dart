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

  // Full list of deals (never filtered)
  Rx<PaginatedDeals?> allDeals = Rx<PaginatedDeals?>(null);

  // Filtered list for the "All Deals" page
  Rx<PaginatedDeals?> paginatedDeals = Rx<PaginatedDeals?>(null);

  TextEditingController dealSearchController = TextEditingController();

  RxList<String> dealsStatusFilters =
      statusStyles.keys.map((key) => key).toList().obs;

  RxString selectedDealFilter = statusStyles.keys.first.obs;

  List<DealStatus> dealsStatus = [
    DealStatus(id: 0, name: "Prise de contact"),
    DealStatus(id: 1, name: "Depot d'offre"),
    DealStatus(id: 2, name: "En cours"),
    DealStatus(id: 3, name: "Conclusion"),
    DealStatus(id: 5, name: "On hold")
  ];

  Timer? _dealsDebounce;

  @override
  void onInit() {
    super.onInit();
    loadDeals();
    dealSearchController.addListener(() {
      if (_dealsDebounce?.isActive ?? false) _dealsDebounce?.cancel();
      _dealsDebounce = Timer(const Duration(milliseconds: 700), () {
        applyFilter();
      });
    });
  }

  Future<void> loadDeals() async {
    loadingDeals.value = true;
    errorLoadingDeals.value = false;

    final PaginatedDeals? allResult = await DealsService().getAllDeals(
      '',
      null,
    );

    if (allResult != null) {
      allDeals.value = allResult;
    } else {
      errorLoadingDeals.value = true;
    }

    await applyFilter();

    loadingDeals.value = false;
  }

  /// Applies filter to allDeals and updates paginatedDeals
  Future<void> applyFilter() async {
    loadingDeals.value = true;
    errorLoadingDeals.value = false;

    final String? statusValue = selectedDealFilter.value != "empty"
        ? statusStyles[selectedDealFilter.value]?.value
        : null;

    final PaginatedDeals? filteredResult = await DealsService().getAllDeals(
      dealSearchController.text,
      statusValue,
    );

    if (filteredResult != null) {
      paginatedDeals.value = filteredResult;
    } else {
      errorLoadingDeals.value = true;
    }

    loadingDeals.value = false;
  }

  /// Sets the selected filter and applies it without touching allDeals
  void filterDeals(String filter) {
    selectedDealFilter.value = filter;
    applyFilter();
  }
}
