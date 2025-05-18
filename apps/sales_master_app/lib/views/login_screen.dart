import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/auth_controller.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingXl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: paddingXmm,
              ),
              Text(
                AppLocalizations.of(context)!.login_page_hint,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: paddingXxxl,
              ),
              SvgPicture.asset(
                "assets/lock.svg",
                height: 74,
                width: 74,
              ),
              SizedBox(
                height: paddingXm,
              ),
              Text(AppLocalizations.of(context)!.login_titler,
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(
                height: paddingXxs,
              ),
              Text(
                AppLocalizations.of(context)!.login_description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: paddingM,
              ),
              DottedLine(
                direction: Axis.horizontal,
                dashColor: Theme.of(context).dividerColor,
              ),
              //doted line
              SizedBox(
                height: paddingM,
              ),
              Form(
                key: authController.msisddnFormKey,
                child: CustomTextFormField(
                  login: true,
                  prifixIcon: Icon(
                    Icons.phone,
                    color: Theme.of(context).iconTheme.color,
                    size: 24,
                  ),
                  controller: authController.msisdnController,
                  validator: (String? msisdn) {
                    return authController.validateMsisdn(msisdn);
                  },
                  hintText: AppLocalizations.of(context)!.login_hint,
                  filled: true,
                  textFormaters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              SizedBox(
                height: paddingXm,
              ),
              RichText(
                textAlign: TextAlign.center, // Optional, center the text
                text: TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: 14), // Default style
                  children: [
                    TextSpan(
                        text: AppLocalizations.of(context)!.by_clicking,
                        style: Theme.of(context).textTheme.labelSmall),
                    TextSpan(
                      text: AppLocalizations.of(context)!.terms_of_service,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.and,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextSpan(
                        text: AppLocalizations.of(context)!.privacy_policy,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),

              SizedBox(
                height: paddingXxxxxl,
              ),
              PrimaryButton(
                onTap: () {
                  bool res = authController.login();
                  if (res == true) {
                    context.push(AppRoutes.otpValidation.path);
                  }
                },
                text: AppLocalizations.of(context)!.next,
              )
            ],
          ),
        ),
      )),
    );
  }
}
