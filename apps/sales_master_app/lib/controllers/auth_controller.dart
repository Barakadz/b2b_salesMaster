import 'package:data_layer/data_layer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/controllers/currentuser_controller.dart';
import 'package:timer_count_down/timer_controller.dart';

class AuthController extends GetxController {
  Rx<bool> isLoged = false.obs;
  TextEditingController msisdnController = TextEditingController();
  final GlobalKey<FormState> msisdnFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  Rx<String?> msisdn = Rx<String?>(null);

  bool prod = false;
  late String baseUrl;

  @override
  void onInit() {
    isLoged.value = AppStorage().getToken() != null;
    baseUrl = prod == true
        ? "http://10.14.1.8:8000/api/v1"
        : "http://10.14.1.8:8000/api/v1/uat";
    super.onInit();
  }

  final Rx<CountdownController> otpTimerController =
      CountdownController(autoStart: true).obs;

  String? validateMsisdn(String? value) {
    if (value == null || value.isEmpty) {
      return "username_required";
    }
    if (value.length < 10) {
      return "number must be 10 charachers long";
    }
    if (value.substring(0, 2) != "07") {
      return "not valid djezzy number";
    }
    return null;
  }

  String? getMsisdn() {
    return msisdn.value ?? AppStorage().getMsisdn();
  }

  String getBaseUrl() {
    return getMsisdn() == null ? baseUrl : "$baseUrl/${getMsisdn()}";
  }

  bool sendOtp() {
    if (msisdnFormKey.currentState!.validate() != true) {
      return false;
    }
    msisdn.value = msisdnController.text;
    print(msisdn.value);
    return true;
  }

  bool login() {
    //validate otp then if correct
    isLoged.value = true;
    AppStorage().setMsisdn(msisdn.value!);
    Api.getInstance().setBaseUrl(getBaseUrl());
    Get.put(CurrentuserController());
    print("baseurl");
    print(getBaseUrl());
    return true;
  }
}
