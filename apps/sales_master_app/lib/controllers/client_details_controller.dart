import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/models/client.dart';
import 'package:sales_master_app/services/clients_service.dart';
import 'package:sales_master_app/widgets/snackbarWidget.dart';

class ClientDetailsController extends GetxController {
  TextEditingController telecomTextController = TextEditingController();
  TextEditingController raisonSocialeTextController = TextEditingController();
  TextEditingController momTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
TextEditingController lastVisitDateController = TextEditingController();


Rx<DateTime?> lastVisitDate = Rx<DateTime?>(null);
Rx<DateTime?> nextVisitDate = Rx<DateTime?>(null);

 TextEditingController nextVisitDateController = TextEditingController();


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
    lastVisitDateController.text = details.lastVisiteDate ?? "";

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
String formatDateTime(DateTime date) {
  return "${date.year.toString().padLeft(4, '0')}-"
         "${date.month.toString().padLeft(2, '0')}-"
         "${date.day.toString().padLeft(2, '0')} "
         "${date.hour.toString().padLeft(2, '0')}:"
         "${date.minute.toString().padLeft(2, '0')}:"
         "${date.second.toString().padLeft(2, '0')}";
}

Future<bool> addMom() async {
  updatingMom.value = true;

  String? formattedDate = lastVisitDate.value != null
      ? formatDateTime(lastVisitDate.value!)
      : null;

  bool res = await ClientService().addMom(
    client.id,
    momTextController.text.trim(),
    formattedDate??'',        
  );

  updatingMom.value = false;

  if (res == true) {
    getClientDetails();
    SnackBarHelper.showSuccess("Succès", "momSuccess".tr);
  }

  return res;
}


Future<void> pickDateTime({required bool isNextDate}) async {
  // Determine initial date for the picker
  final DateTime initialDate = lastVisitDate.value ??
        (lastVisitDateController.text.isNotEmpty
            ? DateTime.tryParse(lastVisitDateController.text) ?? DateTime.now()
            : DateTime.now());

  final DateTime? pickedDate = await showDatePicker(
    context: Get.context!,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (pickedDate == null) return;

  final TimeOfDay? pickedTime = await showTimePicker(
    context: Get.context!,
    initialTime: isNextDate
        ? (nextVisitDate.value != null
            ? TimeOfDay.fromDateTime(nextVisitDate.value!)
            : TimeOfDay.now())
        : (lastVisitDate.value != null
            ? TimeOfDay.fromDateTime(lastVisitDate.value!)
            : TimeOfDay.now()),
  );

  if (pickedTime == null) return;

  final DateTime finalDateTime = DateTime(
    pickedDate.year,
    pickedDate.month,
    pickedDate.day,
    pickedTime.hour,
    pickedTime.minute,
  );

  final String formatted =
      "${finalDateTime.year}-${finalDateTime.month.toString().padLeft(2, '0')}-"
      "${finalDateTime.day.toString().padLeft(2, '0')} "
      "${pickedTime.hour.toString().padLeft(2, '0')}:"
      "${pickedTime.minute.toString().padLeft(2, '0')}";

  if (isNextDate) {
    nextVisitDate.value = finalDateTime;
    nextVisitDateController.text = formatted;
  } else {
    lastVisitDate.value = finalDateTime;
    lastVisitDateController.text = formatted;
  }
}


}
