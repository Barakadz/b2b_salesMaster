import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/controllers/deals_controller.dart';
import 'package:sales_master_app/models/besoin_item.dart';
import 'package:sales_master_app/models/deal.dart';
import 'package:sales_master_app/models/deal_status.dart';
import 'package:sales_master_app/services/deals_service.dart';
import 'package:sales_master_app/services/phone_number_serive.dart';
import 'package:sales_master_app/services/utilities.dart';
 
class DealDetailsController extends GetxController {
  // Text controllers
  TextEditingController raisonSociale = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController interlocuteur = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController raEstime = TextEditingController();
  TextEditingController currentOperators = TextEditingController();
  TextEditingController currentForfait = TextEditingController();
  var mesureAccompagnementOuiNon = "".obs; // Oui / Non
 
  TextEditingController mesureAccompagnement = TextEditingController();
  TextEditingController nextVisitMotif = TextEditingController();
  TextEditingController besoinDetails = TextEditingController();
  TextEditingController visitDate = TextEditingController();
  TextEditingController nextVisittDate = TextEditingController();
  TextEditingController mom = TextEditingController();

   int? statusId; // devient optionnel
  int raEstimeValue = 0;

   Rx<bool> saving = false.obs;
  Rx<String> selectedDeal = "Prise de contact".obs;
RxList<BesoinItem> selectedBesoins = <BesoinItem>[].obs;

bool isBesoinSelected(String type) {
  return selectedBesoins.any((e) => e.type == type);
}
void toggleBesoin(String type) {
  if (isBesoinSelected(type)) {
    selectedBesoins.removeWhere((e) => e.type == type);
  } else {
    selectedBesoins.add(BesoinItem(type: type));
  }
}
RxList<DeviceItem> selectedDevices = <DeviceItem>[].obs;
List<String> devices = ['pttoc & accessoires', 'routeur', 'modem', 'handset'];

// Fonction pour toggle
void toggleDevice(String type) {
  final existing =
      selectedDevices.indexWhere((element) => element.type == type);
  if (existing >= 0) {
    selectedDevices.removeAt(existing);
  } else {
    selectedDevices.add(DeviceItem(type: type));
  }
}

bool isDeviceSelected(String type) {
  return selectedDevices.any((e) => e.type == type);
}
 
  // 📋 Listes de statuts
  List<DealStatus> dealsStatus = [
    DealStatus(id: 1, name: "Prise de contact"),
    DealStatus(id: 2, name: "Depot d'offre"),
    DealStatus(id: 3, name: "En cours"),
    DealStatus(id: 4, name: "Conclusion"),
    DealStatus(id: 5, name: "On hold"),
  ];

  List<BesoinStatus> besoin = [
    BesoinStatus(id: 1, name: "voix"),
    BesoinStatus(id: 2, name: "data"),
    BesoinStatus(id: 3, name: "solution"),
  ];

  final Deal? deal;

  DealDetailsController({this.deal});

@override
void onInit() {
  super.onInit();

  // Safe initialization after the first frame
     initializeForm(newDeal: deal);
 }


  // 🔍 Obtenir ID du statut depuis son nom
  int? getStatusIdByName(String name) {
    return dealsStatus.firstWhereOrNull((status) => status.name == name)?.id;
  }

  // ✅ Validation
  String? validateNames(String? name) {
    if (isEmpty(name)) return "required field";
    return null;
  }

  String formatDate(String date) {
    try {
      if (date.isEmpty) return "";
      DateTime parsedDate = DateTime.parse(date);
      return "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
    } catch (e) {
      print("Invalid date format: $date");
      return date;
    }
  }

  String? validateNumber(String? numero, {bool date = false}) {
    if (isEmpty(numero)) return "required field";
    if (numero!.length != (date == true ? 8 : 10)) {
      return "must have 10 numbers";
    }
    return null;
  }

 void initializeForm({Deal? newDeal}) {
  if (newDeal != null) {
    // Text fields
    raisonSociale.text = newDeal.raisonSociale;
    interlocuteur.text = newDeal.interlocuteur;
    numero.text = newDeal.numero;
    raEstime.text = (newDeal.raEstime ?? 0).toString();
    mom.text = newDeal.mom;
    adresse.text = newDeal.adresse;
    currentOperators.text = newDeal.currentOperators;
    currentForfait.text = newDeal.currentForfaits;
    mesureAccompagnement.text = newDeal.mesureAccompagnement ?? '';
    nextVisitMotif.text = newDeal.nextVisitMotif;
    besoinDetails.text = newDeal.besoinDetails ?? '';

    // Dates
    visitDate.text = (newDeal.visitDate.length >= 10)
        ? newDeal.visitDate.substring(0, 10)
        : newDeal.visitDate;
    nextVisittDate.text = (newDeal.nextVisitDate.length >= 10)
        ? newDeal.nextVisitDate.substring(0, 10)
        : newDeal.nextVisitDate;

    // Status
    selectedDeal.value = newDeal.status;
    statusId = getStatusIdByName(newDeal.status);

    // Besoins → create reactive items with controller
 WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedDeal.value = newDeal.status;
      statusId = getStatusIdByName(newDeal.status);

      selectedBesoins.value = newDeal.besoins
          .map((b) => BesoinItem(type: b.type, details: b.details))
          .toList();

      selectedDevices.value = newDeal.devices
          .map((d) => DeviceItem(type: d.type, details: d.details))
          .toList();
    });
  } else {
    // Reset form
    raisonSociale.clear();
    interlocuteur.clear();
    numero.clear();
    raEstime.clear();
    mom.clear();
    adresse.clear();
    currentOperators.clear();
    currentForfait.clear();
    mesureAccompagnement.clear();
    nextVisitMotif.clear();
    besoinDetails.clear();
    visitDate.clear();
    nextVisittDate.clear();

   WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedDeal.value = dealsStatus.first.name;
      statusId = getStatusIdByName(dealsStatus.first.name);
      selectedBesoins.clear();
      selectedDevices.clear();
    });
  }
}

  // 🧾 Convertir les chaînes séparées par |
  List<String> get currentOperatorsList => currentOperators.text
      .split('|')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  List<String> get currentForfaitsList => currentForfait.text
      .split('|')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  // 📦 Données du formulaire
  Map<String, dynamic> get _formData {
    return {
      "raison_social": raisonSociale.text.trim(),
      "interlocutor_name": interlocuteur.text.trim(),
      "numero_telephone": formatPhoneNumber(numero.text.trim()),
      "visit_date": "${formatDate(visitDate.text.trim())} 00:00:00",
      "next_visit_date": "${formatDate(nextVisittDate.text.trim())} 00:00:00",
      "status_id": getStatusIdByName(selectedDeal.value),
      "mom": mom.text.trim(),
  // ✅ Besoins with details
    "besoin": selectedBesoins.map((b) {
      return {
        "type": b.type,
        if (b.details.value.trim().isNotEmpty)
          "details": b.details.value.trim(),
      };
    }).toList(),

    // ✅ Devices with details
    "device": selectedDevices.map((d) {
      return {
        "type": d.type,
        if (d.details.value.trim().isNotEmpty)
          "details": d.details.value.trim(),
      };
    }).toList(),

      "ra_estime": int.tryParse(raEstime.text.trim()) ?? 0,
      "current_operators": currentOperatorsList,
      "current_forfaits": currentForfaitsList,
      "mesure_accompagnement":  mesureAccompagnement.text.trim().isNotEmpty ? mesureAccompagnement.text.trim() : "",
      "next_visit_motif": nextVisitMotif.text.trim(),
      "besoin_details": besoinDetails.text.trim(),
      "adresse": adresse.text.trim(),
    };
  }

   Future<bool> createNewDeal() async {
    saving.value = true;
    print("status id : ${getStatusIdByName(selectedDeal.value)}");
    print("########### DATA ###########");
    print(_formData);

    bool res = await DealsService().createDeal(_formData);
    print('res=========>$res');
    saving.value = false;
    selectedBesoins.clear();
    selectedDevices.clear();
    Get.find<DealsController>().loadDeals();
    return res;
  }

  // ✏️ Édition d’un deal existant
  Future<bool> editDeal(int dealId) async {
    saving.value = true;
            print("########### DATA ###########");
        print("########### DATA ###########");
        print("########### DATA ###########");
        print("########### DATA ###########");
        print("########### DATA ###########");
        print("########### DATA ###########");
        print("########### DATA ###########");
        print("########### DATA ###########");
        print("########### DATA ###########");
    print(_formData);
    bool res = await DealsService().updateDeal(dealId, _formData);
    print("--------------------------------------------------------------------------");
        print("--------------------------------------------------------------------------");
    print("--------------------------------------------------------------------------");
    print("--------------------------------------------------------------------------");
    print("--------------------------------------------------------------------------");
    print("--------------------------------------------------------------------------");
    print("--------------------------------------------------------------------------");
    print("--------------------------------------------------------------------------");
    print("--------------------------------------------------------------------------");
    print(res);
    saving.value = false;
  Get.find<DealsController>().loadDeals();
    return res;
  }
}
