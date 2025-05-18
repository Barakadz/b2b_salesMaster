import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';

class AuthController extends GetxController {
  Rx<bool> isLoged = false.obs;
  TextEditingController msisdnController = TextEditingController();
  final GlobalKey<FormState> msisddnFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  String msisdn = "";

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

  bool login() {
    if (msisddnFormKey.currentState!.validate() != true) {
      return false;
    }
    msisdn = msisdnController.text;
    return true;
  }
}
