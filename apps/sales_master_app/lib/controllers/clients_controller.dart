import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/controllers/baddebt_details_controller.dart';
import 'package:sales_master_app/controllers/client_details_controller.dart';
import 'package:sales_master_app/models/baddebt.dart';
import 'package:sales_master_app/models/client.dart';
import 'package:sales_master_app/services/clients_service.dart';

class ClientsController extends GetxController {
  Rx<bool> loadingClients = false.obs;
  RxList<ClientListItem> clients = <ClientListItem>[].obs;

  Rx<bool> loadingBadDebts = false.obs;
  RxList<BadDebt> badDebts = <BadDebt>[].obs;

  Rx<bool> onClientsView = true.obs;

  Rx<ClientListItem?> selectedClient = null.obs;
  Rx<ClientListItem?> selectedBadDebt = null.obs;

  TextEditingController telecomManagerTextController = TextEditingController();
  final RxString _searchQuery = ''.obs;

  Timer? _debounceTimer;

  // @override
  // void onInit() {
  //   getClients();
  //   loadingBadDebts();
  //   super.onInit();
  // }

  @override
  void onInit() {
    super.onInit();

    // Listen to text field and debounce search
    telecomManagerTextController.addListener(() {
      _searchQuery.value = telecomManagerTextController.text;
    });

    debounce<String>(
      _searchQuery,
      (String _) => getClients(), // Calls getClients() after user stops typing
      time: const Duration(milliseconds: 700),
    );

    getClients(); // initial fetch
    loadBadDebts();
  }

  void switchiew() {
    onClientsView.toggle();
    if (onClientsView.value == true) {
      getClients();
    } else {
      loadBadDebts();
    }
  }

  Future<void> getClients() async {
    loadingClients.value = true;

    final PaginatedClientListItem? result = await ClientService().getAllClients(
        searchQuery: _searchQuery.value.isNotEmpty ? _searchQuery.value : null);

    if (result != null) {
      clients.assignAll(result.clients);
    } else {
      clients.clear();
    }

    loadingClients.value = false;
  }

  // Future<void> getClients() async {
  //   loadingClients.value = true;
  //   clients.assignAll([
  //     Client(
  //         id: 1,
  //         companyName: "Cevitale",
  //         telecomManager: "Mohamed amine",
  //         openBills: 2,
  //         msisdnCount: 150,
  //         annualRevenue: 1200000,
  //         totalUnpaid: 300000,
  //         lastBill: 400000,
  //         msisdn: "0753468765",
  //         isTopClient: true,
  //         active: true,
  //         reconduction: "",
  //         offers: 2,
  //         globalDueAj: 65598888,
  //         expirationDate: DateTime.now().add(Duration(days: 30))),
  //     Client(
  //         id: 2,
  //         companyName: "CNEP",
  //         telecomManager: "Mohammed ryad",
  //         openBills: 2,
  //         msisdnCount: 150,
  //         annualRevenue: 1200000,
  //         totalUnpaid: 300000,
  //         lastBill: 400000,
  //         msisdn: "0776728765",
  //         isTopClient: true,
  //         reconduction: "",
  //         offers: 3,
  //         globalDueAj: 65598888,
  //         active: true,
  //         expirationDate: DateTime.now().add(Duration(days: 23))),
  //     Client(
  //         id: 3,
  //         companyName: "Air Algerie",
  //         telecomManager: "Mohamed ryad",
  //         globalDueAj: 65598888,
  //         openBills: 2,
  //         msisdnCount: 150,
  //         offers: 5,
  //         reconduction: "",
  //         annualRevenue: 1200000,
  //         totalUnpaid: 300000,
  //         lastBill: 400000,
  //         msisdn: "0753473565",
  //         isTopClient: true,
  //         active: true,
  //         expirationDate: DateTime.now().add(Duration(days: 30)))
  //   ]);
  //   loadingClients.value = true;
  // }

  Future<void> loadBadDebts() async {
    loadingBadDebts.value = true;
    badDebts.assignAll([
      BadDebt(
          id: 1,
          companyName: "Air Algerie",
          openBills: 2,
          msisdnCount: 150,
          lastBill: 400000,
          globalDueAJ: 70000000,
          globalDue: 9000000,
          isActive: true,
          phoneNumber: "0778753765",
          numbers: "0709876543"),
      BadDebt(
        id: 2,
        companyName: "Cevitale",
        globalDueAJ: 60000000,
        globalDue: 7000000,
        msisdnCount: 120,
        isActive: true,
        phoneNumber: "0771843765",
        openBills: 2,
        numbers: "0709876543",
        lastBill: 400000,
      ),
    ]);

    loadingBadDebts.value = false;
  }

  void setClient(ClientListItem client) {
    // Get.put(ClientDetailsController(client: client));
  }

  void setBadDebt(BadDebt client) {
    Get.put(BaddebtDetailsController(baddebt: client));
  }
}
