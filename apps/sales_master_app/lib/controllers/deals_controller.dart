import 'package:get/get.dart';
import 'package:sales_master_app/models/deal.dart';
import 'package:sales_master_app/models/deal_status.dart';

class DealsController extends GetxController {
  Rx<bool> loadingDeals = false.obs;
  Rx<bool> errorLoadingDeals = false.obs;
  RxList<Deal> deals = <Deal>[].obs;

  List<DealStatus> dealsStatus = [
    DealStatus(id: 0, name: "prise de contact"),
    DealStatus(id: 1, name: "depot d'offre"),
    DealStatus(id: 2, name: "en cours"),
    DealStatus(id: 3, name: "conclusion"),
    DealStatus(id: 5, name: "on hold")
  ];

  void loadDeals() async {
    loadingDeals.value = true;
    errorLoadingDeals.value = false;

    // fetch deals using deals service

    await Future.delayed(Duration(seconds: 3));
    deals.assignAll([
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

    loadingDeals.value = false;
    errorLoadingDeals.value = false;
    print(deals.length);
  }
}
