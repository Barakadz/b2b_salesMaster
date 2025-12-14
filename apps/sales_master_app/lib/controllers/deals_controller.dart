import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/deal_status_style.dart';
import 'package:sales_master_app/models/deal.dart';
import 'package:sales_master_app/models/deal_status.dart';
import 'package:sales_master_app/services/deals_service.dart';

class DealsController extends GetxController {
 
  RxBool loadingDeals = false.obs;
  RxBool errorLoadingDeals = false.obs;
  RxBool isLoadingMore = false.obs;

   RxInt currentPage = 1.obs;
  RxInt lastPage = 1.obs;

   RxList<Deal> deals = <Deal>[].obs;
 
  TextEditingController searchController = TextEditingController();
  RxString selectedDealFilter = statusStyles.keys.first.obs;

  RxList<String> dealsStatusFilters =
      statusStyles.keys.map((key) => key).toList().obs;
  Timer? _searchDebounce;

  @override
  void onInit() {
    super.onInit();

    loadDeals(reset: true);

     searchController.addListener(() {
      if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();
      _searchDebounce =
          Timer(const Duration(milliseconds: 600), () => applyFilter());
    });
  }

 
  Future<void> loadDeals({bool reset = false}) async {
    if (reset) {
      currentPage.value = 1;
      deals.clear();
    }

    loadingDeals.value = true;
    errorLoadingDeals.value = false;

    try {
      final statusValue = _mapFilterToStatus();

      final PaginatedDeals? result = await DealsService().getAllDeals(
        searchQuery: searchController.text,
        status: statusValue,
        page: currentPage.value,
      );

      if (result != null) {
        lastPage.value = result.lastPage;

         deals.addAll(result.deals);
      } else {
        errorLoadingDeals.value = true;
      }
    } catch (e) {
      errorLoadingDeals.value = true;
    }

    loadingDeals.value = false;
  }
 
  Future<void> loadMoreDeals() async {
    if (isLoadingMore.value) return;
    if (currentPage.value >= lastPage.value) return;

    isLoadingMore.value = true;

    currentPage.value += 1;

    try {
      final statusValue = _mapFilterToStatus();

      final PaginatedDeals? result = await DealsService().getAllDeals(
        searchQuery: searchController.text,
        status: statusValue,
        page: currentPage.value,
      );

      if (result != null) {
        deals.addAll(result.deals);
      }
    } catch (_) {}

    isLoadingMore.value = false;
  }

 
  Future<void> applyFilter() async {
    await loadDeals(reset: true);
  }

  void filterDeals(String filter) {
    selectedDealFilter.value = filter;
    applyFilter();
  }
 
  String? _mapFilterToStatus() {
    return selectedDealFilter.value != "empty"
        ? statusStyles[selectedDealFilter.value]?.value
        : null;
  }
}
