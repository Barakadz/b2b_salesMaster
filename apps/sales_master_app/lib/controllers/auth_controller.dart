import 'package:core_utility/core_utility.dart';
import 'package:data_layer/data_layer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:sales_master_app/services/auth_service.dart';
import 'package:timer_count_down/timer_controller.dart';

class AuthController extends GetxController {
  Rx<bool> isLoged = false.obs;
  TextEditingController msisdnController = TextEditingController();
  final GlobalKey<FormState> msisdnFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  Rx<String?> msisdn = Rx<String?>(null);

  late OTPTextEditController controller;

  bool prod = false;
  late String baseUrl;

  String testPhoneNumber = '770901100';

  final AuthService _authService = AuthService();

  Rx<bool> requestingOtp = false.obs;
  Rx<bool> verifyingOtp = false.obs;

  @override
  void onInit() {
    isLoged.value = AppStorage().getToken() != null;
    baseUrl = prod == true
        ? "https://apim.djezzy.dz/prod/djezzy-api/b2b/master/api/v1"
        : "https://apim.djezzy.dz/uat/djezzy-api/b2b/master/api/v1";
    super.onInit();
  }

  final Rx<CountdownController> otpTimerController =
      CountdownController(autoStart: true).obs;

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

  Future<bool> sendOtp() async {
    requestingOtp.value = true;
    if (msisdnFormKey.currentState?.validate() != true) return false;

    msisdn.value = msisdnController.text;
    final success = await _authService.requestOtp(msisdn.value!);
    requestingOtp.value = false;

    if (!success) {
      SnackbarService.showCustomMessage(
          message:
              "this phone number is not known by djezzy, please contact the admin",
          title: "Unknown number");
      return false;
    }
    return success;
  }

  Future<bool> login(String otp) async {
    verifyingOtp.value = true;
    final AuthTokens? tokens = await _authService.verifyOtp(
      msisdnRaw: msisdn.value!,
      otp: otp,
    );
    verifyingOtp.value = false;

    if (tokens != null) {
      Api.getInstance().setToken(token: tokens.accessToken);
      Api.getInstance().setRefreshToken(refreshToken: tokens.refreshToken);

      AppStorage().setMsisdn(AuthService().formatMsisdn(msisdn.value!));
      Api.getInstance().setBaseUrl(
        _authService.userScopedBaseUrl(msisdn.value!),
      );

      isLoged.value = true;
      final testBaseUrl =
          "${baseUrl}/${AuthService().formatMsisdn(msisdn.value!)}";
      Api.getInstance().setBaseUrl(testBaseUrl);
      return true;
    }
    SnackbarService.showCustomMessage(
        message: "please make sure the otp is correct", title: "Auth error");

    return false;
  }

  Future<void> logout() async {
    await _authService.logout();
    AppStorage().clearAll();
    isLoged.value = false;
  }
}

class SampleStrategy extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(seconds: 4),
      () => 'Verification Code : 828439.',
    );
  }
}
