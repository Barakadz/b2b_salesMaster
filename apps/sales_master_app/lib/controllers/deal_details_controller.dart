import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sales_master_app/models/deal.dart';
import 'package:sales_master_app/models/deal_status.dart';

class DealDetailsController extends GetxController {
  TextEditingController raisonSociale = TextEditingController();
  TextEditingController interlocuteur = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController visitDate = TextEditingController();
  TextEditingController nextVisittDate = TextEditingController();
  late String status;
  TextEditingController mom = TextEditingController();

  Rx<String> selectedDeal = "prise de contact".obs;

  List<DealStatus> dealsStatus = [
    DealStatus(id: 0, name: "prise de contact"),
    DealStatus(id: 1, name: "depot d'offre"),
    DealStatus(id: 2, name: "en cours"),
    DealStatus(id: 3, name: "conclusion"),
    DealStatus(id: 5, name: "on hold")
  ];

  DealDetailsController({this.deal});

  final Deal? deal;

  @override
  void onInit() {
    super.onInit();
    if (deal != null) {
      raisonSociale.text = deal!.raisonSociale;
      interlocuteur.text = deal!.interlocuteur;
      numero.text = deal!.numero;
      visitDate.text = deal!.visitDate;
      nextVisittDate.text = deal!.nextVisittDate;
      status = deal!.status;
      mom.text = deal!.mom;
    }
  }
}
