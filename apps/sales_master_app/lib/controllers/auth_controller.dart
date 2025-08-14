import 'package:data_layer/data_layer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/services/auth_service.dart';
import 'package:timer_count_down/timer_controller.dart';

class AuthController extends GetxController {
  Rx<bool> isLoged = false.obs;
  TextEditingController msisdnController = TextEditingController();
  final GlobalKey<FormState> msisdnFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  Rx<String?> msisdn = Rx<String?>(null);

  bool prod = false;
  late String baseUrl;

  final AuthService _authService = AuthService();

  @override
  void onInit() {
    isLoged.value = AppStorage().getToken() != null;
    baseUrl = prod == true
        ? "https://apim.djezzy.dz/prod/djezzy-api/b2b/master/api/v1/"
        : "https://apim.djezzy.dz/uat/djezzy-api/b2b/master/api/v1/";
    super.onInit();
  }

  final Rx<CountdownController> otpTimerController =
      CountdownController(autoStart: true).obs;

  // String? validateMsisdn(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "username_required";
  //   }
  //   if (value.length < 10) {
  //     return "number must be 10 charachers long";
  //   }
  //   if (value.substring(0, 2) != "07") {
  //     return "not valid djezzy number";
  //   }
  //   return null;
  // }

  String? validateMsisdn(String? value) {
    if (value == null || value.isEmpty) {
      return "username_required";
    }
    final v = value.trim();
    if (v.startsWith('0')) {
      if (v.length != 10) return "Number must be 10 digits long with leading 0";
    } else {
      if (v.length != 9)
        return "Number must be 9 digits long without leading 0";
    }
    if (!v.startsWith('07') && !v.startsWith('7')) {
      return "Not a valid Djezzy number";
    }
    return null;
  }

  String? getMsisdn() {
    return msisdn.value ?? AppStorage().getMsisdn();
  }

  String getBaseUrl() {
    return getMsisdn() == null ? baseUrl : "$baseUrl/${getMsisdn()}";
  }

  // bool sendOtp() {
  //   if (msisdnFormKey.currentState!.validate() != true) {
  //     return false;
  //   }
  //   msisdn.value = msisdnController.text;
  //   print(msisdn.value);
  //   return true;
  // }

  Future<bool> sendOtp() async {
    if (msisdnFormKey.currentState?.validate() != true) return false;

    msisdn.value = msisdnController.text;
    final success = await _authService.requestOtp(msisdn.value!);

    if (!success) {
      Get.snackbar("Error", "Failed to send OTP");
    }
    return success;
  }

  Future<bool> login(String otp) async {
    final tokens = await _authService.verifyOtp(
      msisdnRaw: msisdn.value!,
      otp: otp,
    );

    if (tokens != null) {
      await Api.getInstance().setToken(token: tokens.accessToken);
      if (tokens.refreshToken != null) {
        await Api.getInstance()
            .setRefreshToken(refreshToken: tokens.refreshToken!);
      }
      AppStorage().setMsisdn(msisdn.value!);
      Api.getInstance().setBaseUrl(
        _authService.userScopedBaseUrl(msisdn.value!),
      );
      isLoged.value = true;
      return true;
    }

    Get.snackbar("Error", "Invalid OTP");
    return false;
  }

  //bool login() {
  //  //validate otp then if correct
  //  isLoged.value = true;
  //  AppStorage().setMsisdn(msisdn.value!);
  //  Api.getInstance().setBaseUrl(getBaseUrl());
  //  Get.put(CurrentuserController());
  //  print("baseurl");
  //  print(getBaseUrl());
  //  return true;
  //}
}
