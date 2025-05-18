import 'package:get/get.dart';
import 'package:sales_master_app/models/client.dart';

class ClientsController extends GetxController {
  Rx<bool> loadingClients = false.obs;
  RxList<Client> clients = <Client>[].obs;

  Future<void> getClients() async {
    //set loading true
    //fetch clients
    //set loading false
    clients.value = [
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
          expirationDate: DateTime.now().add(Duration(days: 30)))
    ];
  }
}
