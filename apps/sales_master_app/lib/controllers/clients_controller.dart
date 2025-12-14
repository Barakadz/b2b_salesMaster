import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/models/baddebt.dart';
import 'package:sales_master_app/models/client.dart';
import 'package:sales_master_app/services/clients_service.dart';

class ClientsController extends GetxController {
  Rx<bool> loadingClients = false.obs;
  Rx<bool> errorLoadingClients = false.obs;
  RxList<ClientListItem> clients = <ClientListItem>[].obs;

  Rx<bool> loadingBadDebts = false.obs;
  Rx<bool> errorLoadingBadDebts = false.obs;
  RxList<ClientListItem> badDebts = <ClientListItem>[].obs;

  Rx<bool> onClientsView = true.obs;

  Rx<ClientListItem?> selectedClient = null.obs;
  Rx<ClientListItem?> selectedBadDebt = null.obs;

  TextEditingController telecomManagerTextController = TextEditingController();
  final RxString _searchQuery = ''.obs;

  Timer? _debounceTimer;

RxInt currentPageClients = 1.obs;
RxInt lastPageClients = 1.obs;
RxBool isLoadingMoreClients = false.obs;
RxInt currentPageBadDebts = 1.obs;
RxInt lastPageBadDebts = 1.obs;
RxBool isLoadingMoreBadDebts = false.obs;



  @override
  void onInit() {
    super.onInit();

    // Listen to text field and debounce search
    telecomManagerTextController.addListener(() {
      _searchQuery.value = telecomManagerTextController.text;
    });

    bool firstRun = true;

    debounce<String>(
      _searchQuery,
      // (String _) => onClientsView.value == true ? getClients() : loadBadDebts(),
      (String query) {
        if (firstRun) {
          firstRun = false;
          return; // ignore initial empty value
        }
        if (onClientsView.value) {
          getClients();
        } else {
          loadBadDebts();
        }
      },
      time: const Duration(milliseconds: 700),
    );

    getClients(); // initial fetch
  }

  void switchiew() {
    onClientsView.toggle();
    if (onClientsView.value == true) {
      getClients();
    } else {
      loadBadDebts();
    }
  }

  Future<void> getClients({bool isLoadMore = false}) async {
  if (!isLoadMore) {
    loadingClients.value = true;
    clients.clear();
    currentPageClients.value = 1;
  } else {
    if (currentPageClients.value >= lastPageClients.value) return;
    isLoadingMoreClients.value = true;
    currentPageClients.value += 1;
  }

  final PaginatedClientListItem? result = await ClientService().getAllClients(
      searchQuery: _searchQuery.value.isNotEmpty ? _searchQuery.value : null,
      page: currentPageClients.value); // <-- add page parameter in service

  if (result != null) {
    lastPageClients.value = result.lastPage;
    if (isLoadMore) {
      clients.addAll(result.clients);
    } else {
      clients.assignAll(result.clients);
    }
    errorLoadingClients.value = false;
  } else {
    if (!isLoadMore) {
      errorLoadingClients.value = true;
      clients.clear();
    }
  }

  loadingClients.value = false;
  isLoadingMoreClients.value = false;
}


  Future<void> loadBadDebts({bool isLoadMore = false}) async {
  if (!isLoadMore) {
    loadingBadDebts.value = true;
    badDebts.clear();
    currentPageBadDebts.value = 1;
  } else {
    if (currentPageBadDebts.value >= lastPageBadDebts.value) return;
    isLoadingMoreBadDebts.value = true;
    currentPageBadDebts.value += 1;
  }

  final PaginatedClientListItem? result = await ClientService().getAllClients(
    searchQuery: _searchQuery.value.isNotEmpty ? _searchQuery.value : null,
    status: "baddebt",
    page: currentPageBadDebts.value, // pass page number
  );

  if (result != null) {
    lastPageBadDebts.value = result.lastPage;
    if (isLoadMore) {
      badDebts.addAll(result.clients);
    } else {
      badDebts.assignAll(result.clients);
    }
    errorLoadingBadDebts.value = false;
  } else {
    if (!isLoadMore) {
      errorLoadingBadDebts.value = true;
      badDebts.clear();
    }
  }

  loadingBadDebts.value = false;
  isLoadingMoreBadDebts.value = false;
}


  void setClient(ClientListItem client) {
    // Get.put(ClientDetailsController(client: client));
  }

  void setBadDebt(BadDebt client) {
    //   Get.put(BaddebtDetailsController(baddebt: client));
  }
}
