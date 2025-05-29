import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/models/client.dart';

class ClientsController extends GetxController {
  Rx<bool> loadingClients = false.obs;
  RxList<Client> clients = <Client>[].obs;

  Rx<bool> loadingBadDebts = false.obs;
  RxList<Client> badDebts = <Client>[].obs;

  Rx<bool> on_clients_view = true.obs;

  Rx<Client?> selectedClient = null.obs;

  TextEditingController telecomManagerTextController = TextEditingController();

  @override
  void onInit() {
    getClients();
    loadingBadDebts();
    super.onInit();
  }

  void switchiew() {
    on_clients_view.toggle();
    if (on_clients_view.value == true) {
      getClients();
    } else {
      loadBadDebts();
    }
  }

  void openTelecomManagerUpdateDialog(BuildContext context) {
    // Get.dialog(Container(
    //   constraints: BoxConstraints(maxWidth: 350),
    //   decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
    //   child: Column(),
    // ));
  }

  Future<void> getClients() async {
    //set loading true
    //fetch clients
    //set loading false
    clients.assignAll([
      Client(
          companyName: "Cevitale",
          telecomManager: "Mohamed amine",
          openBills: 2,
          msisdnCount: 150,
          annualRevenue: 1200000,
          totalUnpaid: 300000,
          lastBill: 400000,
          msisdn: "0753468765",
          isTopClient: true,
          active: true,
          globalDueAj: 65598888,
          expirationDate: DateTime.now().add(Duration(days: 30))),
      Client(
          companyName: "CNEP",
          telecomManager: "Mohammed ryad",
          openBills: 2,
          msisdnCount: 150,
          annualRevenue: 1200000,
          totalUnpaid: 300000,
          lastBill: 400000,
          msisdn: "0776728765",
          isTopClient: true,
          globalDueAj: 65598888,
          active: true,
          expirationDate: DateTime.now().add(Duration(days: 23))),
      Client(
          companyName: "Air Algerie",
          telecomManager: "Mohamed ryad",
          globalDueAj: 65598888,
          openBills: 2,
          msisdnCount: 150,
          annualRevenue: 1200000,
          totalUnpaid: 300000,
          lastBill: 400000,
          msisdn: "0753473565",
          isTopClient: true,
          active: true,
          expirationDate: DateTime.now().add(Duration(days: 30)))
    ]);
  }

  Future<void> loadBadDebts() async {
    badDebts.assignAll([
      Client(
          companyName: "Air Algerie",
          telecomManager: "Mohamed ryad",
          globalDueAj: 65598888,
          openBills: 2,
          msisdnCount: 150,
          annualRevenue: 1200000,
          totalUnpaid: 300000,
          lastBill: 400000,
          msisdn: "0753473565",
          isTopClient: true,
          active: true,
          expirationDate: DateTime.now().add(Duration(days: 30))),
      Client(
          companyName: "Cevitale",
          telecomManager: "Mohamed amine",
          openBills: 2,
          msisdnCount: 150,
          annualRevenue: 1200000,
          totalUnpaid: 300000,
          lastBill: 400000,
          msisdn: "0753468765",
          isTopClient: true,
          active: true,
          globalDueAj: 65598888,
          expirationDate: DateTime.now().add(Duration(days: 30))),
    ]);
  }

  void setClient(Client client) {
    selectedClient?.value = client;
  }
}
