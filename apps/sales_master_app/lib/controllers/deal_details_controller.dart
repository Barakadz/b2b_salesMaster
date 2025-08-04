import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/models/deal.dart';
import 'package:sales_master_app/models/deal_status.dart';
import 'package:sales_master_app/services/deals_service.dart';
import 'package:sales_master_app/services/utilities.dart';

class DealDetailsController extends GetxController {
  TextEditingController raisonSociale = TextEditingController();
  TextEditingController interlocuteur = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController visitDate = TextEditingController();
  TextEditingController nextVisittDate = TextEditingController();
  late String status;
  TextEditingController mom = TextEditingController();

  Rx<bool> saving = false.obs;

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

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  String? validateNames(String? name) {
    if (isEmpty(name)) {
      return "required field";
    }
    return null;
  }

  String? validateNumber(String? numero, {bool date = false}) {
    if (isEmpty(numero)) {
      return "required field";
    }
    if (numero!.length != (date == true ? 8 : 10)) {
      return "must have 10 numbers";
    }
    return null;
  }

  void initializeForm({Deal? newDeal}) {
    if (newDeal != null) {
      raisonSociale.text = newDeal.raisonSociale;
      interlocuteur.text = newDeal.interlocuteur;
      numero.text = newDeal.numero;
      visitDate.text = newDeal.visitDate;
      nextVisittDate.text = newDeal.nextVisittDate;
      selectedDeal.value = newDeal.status;
      mom.text = newDeal.mom;
    } else {
      raisonSociale.clear();
      interlocuteur.clear();
      numero.clear();
      visitDate.clear();
      nextVisittDate.clear();
      selectedDeal.value = dealsStatus.first.name;
      mom.clear();
    }
  }

  Map<String, dynamic> get _formData => {
        "raison_social": raisonSociale.text.trim(),
        "interlocutor_name": interlocuteur.text.trim(),
        "numero_telephone": numero.text.trim(),
        "last_visit_date": visitDate.text.trim(),
        "next_visit_date": nextVisittDate.text.trim(),
        "status": selectedDeal.value,
        "mom": mom.text.trim(),
      };

  Future<bool> createNewDeal() async {
    saving.value = true;
    bool res = await DealsService().createDeal(_formData);
    saving.value = false;
    return res;
  }

  Future<bool> editDeal(int dealId) async {
    saving.value = true;
    bool res = await DealsService().updateDeal(dealId, _formData);
    saving.value = false;
    return res;
  }
}
