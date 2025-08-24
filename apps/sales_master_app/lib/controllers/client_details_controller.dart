import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/models/client.dart';
import 'package:sales_master_app/services/clients_service.dart';

class ClientDetailsController extends GetxController {
  TextEditingController telecomTextController = TextEditingController();
  TextEditingController raisonSocialeTextController = TextEditingController();
  TextEditingController momTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  final ClientListItem client;

  Rx<bool> loadingDetails = false.obs;
  Rx<bool> errorLoadingDetails = false.obs;
  Rx<ClientDetails?> clientDetails = Rx<ClientDetails?>(null);

  Rx<bool> updatingTm = false.obs;
  Rx<bool> updatingMom = false.obs;

  final RxString momText = "".obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ClientDetailsController({required this.client});

  @override
  void onInit() {
    super.onInit();
    momTextController.addListener(() {
      momText.value = momTextController.text;
    });
    getClientDetails();
  }

  bool get canSaveMom {
    final currentMom = clientDetails.value?.mom ?? "";
    final newMom = momText.value.trim();
    return newMom.isNotEmpty && newMom != currentMom;
  }

  void setFields(ClientDetails details) {
    raisonSocialeTextController.text = details.tm ?? "";
    momTextController.text = details.mom ?? "";
    momText.value = details.mom ?? "";
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email requis';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Email invalide';
    }
    return null;
  }

  Future<bool> updateEmail() async {
    if (formKey.currentState!.validate()) {
      updatingTm.value = true;
      bool res = await ClientService()
          .updateTm(client.id, emailTextController.text.trim());

      updatingTm.value = false;
      return res;
    }
    return false;
  }

  Future<void> getClientDetails() async {
    loadingDetails.value = true;
    errorLoadingDetails.value = false;

    final ClientDetails? result =
        await ClientService().getClientById(client.id);

    if (result != null) {
      clientDetails.value = result;
      setFields(clientDetails.value!);
    } else {
      errorLoadingDetails.value = true;
      clientDetails.value = null;
    }
    loadingDetails.value = false;
  }

  Future<bool> addMom() async {
    updatingMom.value = true;
    bool res =
        await ClientService().addMom(client.id, momTextController.text.trim());
    updatingMom.value = false;
    if (res == true) {
      getClientDetails();
    }
    return res;
  }
}
