import 'package:data_layer/data_layer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/auth_controller.dart';
import 'package:sales_master_app/services/push_notification_service.dart';
import 'package:sales_master_app/widgets/otp_form.dart';
import 'package:sales_master_app/widgets/primary_button.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  // Generate the controllers in the screen, not inside OtpInput
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.sizeOf(context).width -
            paddingOtpGap -
            (paddingBetweenOtp * 4) -
            (paddingXl * 2)) /
        6;
    AuthController authController = Get.find();

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
                    Text(
                      AppLocalizations.of(context)!.login_page_hint,
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
                Text(
                  AppLocalizations.of(context)!.otp_title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: paddingXxs),
                Text(
                  "${AppLocalizations.of(context)!.code_sent} ${authController.msisdn}",
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
                Text(
                  AppLocalizations.of(context)!.receiving_issue,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  AppLocalizations.of(context)!.resend_code,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                ),
                SizedBox(height: paddingXxxxxl),
                PrimaryButton(
                  onTap: () async {
                    // Build OTP string
                    String otp = otpControllers.map((c) => c.text).join();

                    // Call login with OTP
                    bool res = await authController.login(otp);

                    // Set token and push notifications
                    if (res == true) {
                      PushNotificationService.init(context);
                      context.push(AppRoutes.home.path);
                    }

                    // Navigate to home
                  },
                  text: AppLocalizations.of(context)!.next,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
