import 'package:data_layer/data_layer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/auth_controller.dart';
import 'package:sales_master_app/services/push_notification_service.dart';
import 'package:sales_master_app/widgets/otp_form.dart';
import 'package:sales_master_app/widgets/primary_button.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Generate the controllers in the screen, not inside OtpInput
  late OTPTextEditController otpListener;
  late OTPInteractor _otpInteractor;
  AuthController authController = Get.find();

  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _otpInteractor = OTPInteractor();

    otpListener = OTPTextEditController(
      otpInteractor: _otpInteractor,
      codeLength: 6,
      onCodeReceive: (code) async {
        debugPrint("Auto received OTP: $code");

        // Fill each TextEditingController with the corresponding character
        for (int i = 0; i < code.length && i < otpControllers.length; i++) {
          otpControllers[i].text = code[i];
        }
        bool res = await authController.login(code);

        if (res == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context.push(AppRoutes.home.path);
            }
          });
        }
      },
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [
          // SampleStrategy(),
        ],
      );
  }

  @override
  void dispose() {
    otpListener.stopListen();
    otpListener.dispose();
    for (final c in otpControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.sizeOf(context).width -
            paddingOtpGap -
            (paddingBetweenOtp * 4) -
            (paddingXl * 2)) /
        6;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingXl),
            child: Column(
              children: [
                SizedBox(height: paddingXmm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.west_sharp,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: Theme.of(context).iconTheme.size,
                      ),
                    ),
                    Text("login_page_hint".tr,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Icon(
                      Icons.arrow_back,
                      color: Colors.transparent,
                      size: Theme.of(context).iconTheme.size,
                    ),
                  ],
                ),
                SizedBox(height: paddingXxxl),
                SvgPicture.asset(
                  "assets/shield.svg",
                  height: 74,
                  width: 74,
                ),
                SizedBox(height: paddingXm),
                Text("otp_title".tr,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: paddingXxs),
                Text(
                  "${"code_sent".tr} ${authController.msisdn}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: paddingM),
                DottedLine(
                  direction: Axis.horizontal,
                  dashColor: Theme.of(context).dividerColor,
                ),
                SizedBox(height: paddingM),
                // Pass the controllers to OtpInput
                OtpInput(width: width, controllers: otpControllers),
                SizedBox(height: paddingXm),
                Obx(() {
                  return Countdown(
                    seconds: 60,
                    controller: authController.otpTimerController.value,
                    build: (BuildContext context, double time) => Text(
                      time > 59 ? "1:00" : "0:${time.truncate().toString()}",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    interval: const Duration(milliseconds: 1000),
                    onFinished: () {},
                  );
                }),
                SizedBox(height: paddingM),
                Text("receiving_issue".tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text("resend_code".tr,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                ),
                SizedBox(height: paddingXxxxxl),
                Obx(() {
                  return PrimaryButton(
                    loading: authController.verifyingOtp.value,
                    onTap: () async {
                      // Build OTP string
                      String otp = otpControllers.map((c) => c.text).join();

                      // Call login with OTP
                      bool res = await authController.login(otp);

                      if (res == true) {
                        context.push(AppRoutes.home.path);
                      }
                    },
                    text: "next".tr,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
