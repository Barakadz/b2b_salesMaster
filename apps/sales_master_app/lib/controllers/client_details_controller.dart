import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sales_master_app/models/client.dart';

class ClientDetailsController extends GetxController {
  TextEditingController telecomTextController = TextEditingController();
  TextEditingController raisonSocialeTextController = TextEditingController();
  TextEditingController nombreLignesTextController = TextEditingController();
  TextEditingController offersTextController = TextEditingController();
  TextEditingController reconductionTextController = TextEditingController();
  TextEditingController expirationDateTextController = TextEditingController();
  TextEditingController revenuAnnuelDateTextController =
      TextEditingController();
  TextEditingController openBillsTextController = TextEditingController();
  TextEditingController dueTextController = TextEditingController();
  TextEditingController lastBillTextController = TextEditingController();
  TextEditingController momTextController = TextEditingController();

  final Client client;

  ClientDetailsController({required this.client});

  @override
  void onInit() {
    super.onInit();
    telecomTextController = TextEditingController(text: client.telecomManager);
    raisonSocialeTextController =
        TextEditingController(text: client.companyName);
    nombreLignesTextController =
        TextEditingController(text: client.msisdnCount.toString());
    offersTextController =
        TextEditingController(text: client.offers.toString());
    reconductionTextController =
        TextEditingController(text: client.reconduction);
    expirationDateTextController =
        TextEditingController(text: client.expirationDate?.toString());
    revenuAnnuelDateTextController =
        TextEditingController(text: client.annualRevenue.toString());
    openBillsTextController =
        TextEditingController(text: client.openBills.toString());
    dueTextController =
        TextEditingController(text: client.globalDueAj.toString());
    lastBillTextController =
        TextEditingController(text: client.lastBill.toString());
    momTextController = TextEditingController(text: client.mom);
  }
}
