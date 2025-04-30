import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sales_master_app/widgets/otp_form.dart';
import 'package:sales_master_app/widgets/primary_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingXl),
          child: Column(
            children: [
              SizedBox(
                height: paddingXmm,
              ),
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
              SizedBox(
                height: paddingXxxl,
              ),
              SvgPicture.asset(
                "assets/shield.svg",
                height: 74,
                width: 74,
              ),
              SizedBox(
                height: paddingXm,
              ),
              Text(AppLocalizations.of(context)!.otp_title,
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(
                height: paddingXxs,
              ),
              Text(
                AppLocalizations.of(context)!.code_sent,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: paddingM,
              ),
              DottedLine(
                direction: Axis.horizontal,
                dashColor: Theme.of(context).dividerColor,
              ),
              SizedBox(
                height: paddingM,
              ),
              OtpInput(),
              SizedBox(
                height: paddingXm,
              ),
              Text(
                "04:23",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                height: paddingM,
              ),
              Text(
                AppLocalizations.of(context)!.receiving_issue,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                AppLocalizations.of(context)!.resend_code,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline),
              ),
              SizedBox(
                height: paddingXxxxxl,
              ),
              PrimaryButton(
                onTap: () {},
                text: AppLocalizations.of(context)!.next,
              )
            ],
          ),
        ),
      )),
    );
  }
}
