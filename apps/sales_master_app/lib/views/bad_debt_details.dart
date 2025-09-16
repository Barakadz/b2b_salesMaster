import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/baddebt_details_controller.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/debt_tile.dart';
import 'package:sales_master_app/widgets/error_widget.dart';
import 'package:sales_master_app/widgets/info_container.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';
import 'package:sales_master_app/widgets/my_chip.dart';
import 'package:sales_master_app/widgets/note.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BadDebtDetails extends StatelessWidget {
  final String badDebtId;
  const BadDebtDetails({super.key, required this.badDebtId});

  @override
  Widget build(BuildContext context) {
    final BaddebtDetailsController baddebtDetailsController =
        Get.find(tag: badDebtId);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageDetail(
            title: "my_baddebt".tr,
            goBack: true,
          ),
          Expanded(
            child: Obx(() {
              return baddebtDetailsController.loadingDetails.value == true
                  ? Center(child: LoadingIndicator())
                  : baddebtDetailsController.errorLoadingDetails.value == true
                      ? CustomErrorWidget(
                          onTap: () {
                            baddebtDetailsController.getClientDetails();
                          },
                        )
                      : SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "gestion_portefeuille".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontSize: 16),
                                  ),
                                  // SizedBox(
                                  //   height: formSectionTopPadding,
                                  // ),
                                  // CustomTextFormField(
                                  //   prifixIcon: Icon(
                                  //     Icons.search_outlined,
                                  //     color: Theme.of(context)
                                  //         .colorScheme
                                  //         .onSurfaceVariant
                                  //         .withValues(alpha: 0.15),
                                  //   ),
                                  //   hintText: AppLocalizations.of(context)!
                                  //       .raison_sociale,
                                  //   filled: true,
                                  //   login: false,
                                  // ),
                                  SizedBox(
                                    height: formSectionTopPadding,
                                  ),
                                  Text(
                                    "generale_informations".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant
                                                .withValues(alpha: 0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: formSectionBottomPadding,
                                  ),
                                  InfoContainer(
                                    label: "raison_sociale".tr,
                                    content: baddebtDetailsController
                                        .clientDetails.value!.raisonSociale,
                                    status: MyChip(
                                        text: "call".tr,
                                        bgColor: clientActiveColors[true]
                                            ["bgColor"],
                                        textColor: clientActiveColors[true]
                                            ["textColor"]),
                                  ),
                                  // SizedBox(
                                  //   height: textfieldsPadding,
                                  // ),
                                  // InfoContainer(
                                  //   label: "number".tr,
                                  //   content:
                                  //       "+213 ${baddebtDetailsController.baddebt.msisdnCount}",
                                  //   icon: Icon(
                                  //     Icons.phone_sharp,
                                  //     size: 20,
                                  //     color: Theme.of(context)
                                  //         .colorScheme
                                  //         .onSurfaceVariant
                                  //         .withValues(alpha: 0.15),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: formSectionTopPadding,
                                  ),
                                  Text(
                                    "bills_data".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant
                                                .withValues(alpha: 0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: formSectionBottomPadding,
                                  ),
                                  InfoContainer(
                                    label: "nombre_lignes".tr,
                                    content:
                                        "${baddebtDetailsController.baddebt.msisdnCount} ${"lignes".tr}",
                                  ),
                                  SizedBox(
                                    height: formSectionTopPadding,
                                  ),
                                  InfoContainer(
                                    label: "open_bills".tr,
                                    content:
                                        "${baddebtDetailsController.clientDetails.value?.bill?.countUnpaidBills ?? "undefined"}",
                                  ),
                                  SizedBox(
                                    height: formSectionTopPadding,
                                  ),
                                  Text(
                                    "montant_financier".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant
                                                .withValues(alpha: 0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: formSectionBottomPadding,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .dividerColor
                                              .withValues(alpha: 0.5)),
                                      color: Theme.of(context)
                                          .dividerColor
                                          .withValues(alpha: 0.07),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: paddingXxs,
                                        children: [
                                          DebtTile(
                                            prefix: SvgPicture.asset(
                                              "assets/payment_icon.svg",
                                              height: 14,
                                              width: 14,
                                            ),
                                            label: "last_bill".tr,
                                            content: baddebtDetailsController
                                                    .clientDetails
                                                    .value!
                                                    .bill
                                                    ?.lastBillAmount
                                                    .toString() ??
                                                "undefined",
                                          ),
                                          DebtTile(
                                            label: "global_due".tr,
                                            content: baddebtDetailsController
                                                    .clientDetails
                                                    .value!
                                                    .bill
                                                    ?.unpaidAmount
                                                    .toString() ??
                                                "undefined",
                                          ),
                                          DebtTile(
                                            prefix: Icon(
                                              Icons.circle,
                                              color: Colors.orange,
                                              size: 14,
                                            ),
                                            label: "gloabl_due_aj".tr,
                                            content: baddebtDetailsController
                                                    .clientDetails
                                                    .value!
                                                    .bill
                                                    ?.unpaidAmount
                                                    .toString() ??
                                                "undefined",
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: paddingXxxl,
                                  ),
                                  Note(
                                      info: "contacted_warning".tr),
                                  SizedBox(
                                    height: paddingS,
                                  ),
                                  Container(
                                      width: double.infinity,
                                      child: PrimaryButton(
                                        onTap: () {
                                          baddebtDetailsController.callNumber(
                                              baddebtDetailsController
                                                  .baddebt.msisdnCount
                                                  .toString());
                                        },
                                        text: "call".tr,
                                        height: 45,
                                      ))
                                ],
                              )),
                        );
            }),
          ),
        ],
      )),
    );
  }
}
