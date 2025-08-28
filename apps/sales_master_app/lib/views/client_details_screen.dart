import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/client_details_controller.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/error_widget.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClientDetailsScreen extends StatelessWidget {
  final String clientId;

  const ClientDetailsScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    final ClientDetailsController clientDetailsController =
        Get.find<ClientDetailsController>(tag: clientId);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            PageDetail(
              title: AppLocalizations.of(context)!.mon_portfeuille,
              goBack: true,
            ),
            Expanded(
              child: Obx(() {
                return clientDetailsController.loadingDetails.value == true
                    ? Center(child: LoadingIndicator())
                    : clientDetailsController.errorLoadingDetails.value == true
                        ? CustomErrorWidget(
                            onTap: () {
                              clientDetailsController.getClientDetails();
                            },
                          )
                        : SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(paddingXl),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .gestion_portefeuille,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: formSectionTopPadding,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.prodil_client,
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
                                  CustomTextFormField(
                                    readOnly: true,
                                    hintText: AppLocalizations.of(context)!
                                        .raison_sociale,
                                    initialValue: clientDetailsController
                                        .clientDetails.value?.raisonSociale,
                                    filled: false,
                                  ),
                                  SizedBox(
                                    height: textfieldsPadding,
                                  ),
                                  CustomTextFormField(
                                    readOnly: true,
                                    controller: clientDetailsController
                                        .telecomTextController,
                                    hintText: AppLocalizations.of(context)!
                                        .nom_telecom_manager,
                                    filled: false,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  constraints: BoxConstraints(
                                                      maxWidth: 350),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            paddingL),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/send.svg",
                                                          height: 70,
                                                          width: 70,
                                                        ),
                                                        SizedBox(
                                                          height: paddingS,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .modifier_telecom_manager,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleSmall
                                                              ?.copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        SizedBox(
                                                          height: paddingXxs,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .enter_email,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleSmall
                                                              ?.copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onSurfaceVariant
                                                                      .withValues(
                                                                          alpha:
                                                                              0.5),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                        SizedBox(
                                                          height: paddingS,
                                                        ),
                                                        Material(
                                                          child: Form(
                                                            key:
                                                                clientDetailsController
                                                                    .formKey,
                                                            child:
                                                                CustomTextFormField(
                                                              controller:
                                                                  clientDetailsController
                                                                      .emailTextController,
                                                              validator:
                                                                  (String?
                                                                      value) {
                                                                return clientDetailsController
                                                                    .validateEmail(
                                                                        value);
                                                              },
                                                              customTextField:
                                                                  true,
                                                              innerPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          0,
                                                                      vertical:
                                                                          0),
                                                              prifixIcon:
                                                                  Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border(
                                                                        right: BorderSide(
                                                                            color:
                                                                                Theme.of(context).colorScheme.outline))),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          paddingS),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .mail_sharp,
                                                                        color: Theme.of(context)
                                                                            .dividerColor,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            paddingXs,
                                                                      ),
                                                                      Text(
                                                                        AppLocalizations.of(context)!
                                                                            .mail,
                                                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                                            color:
                                                                                Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.15),
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 14),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: paddingXxs,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .edit_manager_hint,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onSurfaceVariant
                                                                      .withValues(
                                                                          alpha:
                                                                              0.25),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                        SizedBox(
                                                          height: paddingXxl,
                                                        ),
                                                        Obx(() {
                                                          return PrimaryButton(
                                                              loading:
                                                                  clientDetailsController
                                                                      .updatingTm
                                                                      .value,
                                                              height: 45,
                                                              onTap: () async {
                                                                bool res =
                                                                    await clientDetailsController
                                                                        .updateEmail();
                                                                if (res ==
                                                                    true) {
                                                                  context.pop();
                                                                }
                                                              },
                                                              text: AppLocalizations
                                                                      .of(context)!
                                                                  .envoyer);
                                                        })
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }));
                                      },
                                      child: Icon(
                                        Icons.border_color_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: formSectionTopPadding,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .details_abonnement,
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
                                  CustomTextFormField(
                                    readOnly: true,
                                    initialValue: clientDetailsController
                                        .clientDetails.value?.nombreLigne
                                        .toString(),
                                    hintText: AppLocalizations.of(context)!
                                        .nombre_lignes,
                                    labelText: AppLocalizations.of(context)!
                                        .nombre_lignes,
                                  ),
                                  SizedBox(
                                    height: textfieldsPadding,
                                  ),
                                  CustomTextFormField(
                                    readOnly: true,
                                    initialValue: clientDetailsController
                                        .clientDetails.value?.nombreOffre
                                        .toString(),
                                    hintText:
                                        AppLocalizations.of(context)!.offres,
                                    labelText:
                                        AppLocalizations.of(context)!.offres,
                                  ),
                                  SizedBox(
                                    height: textfieldsPadding,
                                  ),
                                  // CustomTextFormField(
                                  //   controller: clientDetailsController
                                  //       .reconductionTextController,
                                  //   hintText: AppLocalizations.of(context)!
                                  //       .reconduction,
                                  //   labelText: AppLocalizations.of(context)!
                                  //       .reconduction,
                                  // ),
                                  // SizedBox(
                                  //   height: textfieldsPadding,
                                  // ),
                                  clientDetailsController.clientDetails.value
                                              ?.expiryDateTop1000 !=
                                          null
                                      ? CustomTextFormField(
                                          readOnly: true,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .expiration_date,
                                          initialValue: clientDetailsController
                                              .clientDetails
                                              .value
                                              ?.expiryDateTop1000,
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .expiration_date,
                                          filled: false,
                                          suffixIcon: Icon(
                                            Icons.calendar_today_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: formSectionTopPadding,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .etat_financier,
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
                                  CustomTextFormField(
                                    readOnly: true,
                                    initialValue: clientDetailsController
                                        .clientDetails.value?.monthlyRevenu
                                        .toString(),
                                    hintText: AppLocalizations.of(context)!
                                        .revenus_mensuels,
                                    labelText: AppLocalizations.of(context)!
                                        .revenus_mensuels,
                                  ),
                                  SizedBox(
                                    height: textfieldsPadding,
                                  ),
                                  CustomTextFormField(
                                    readOnly: true,
                                    initialValue: clientDetailsController
                                        .clientDetails
                                        .value
                                        ?.bill
                                        ?.countUnpaidBills
                                        .toString(),
                                    hintText: AppLocalizations.of(context)!
                                        .open_bills,
                                    labelText: AppLocalizations.of(context)!
                                        .open_bills,
                                  ),
                                  SizedBox(
                                    height: textfieldsPadding,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                          child: CustomTextFormField(
                                        initialValue: clientDetailsController
                                            .clientDetails
                                            .value
                                            ?.bill
                                            ?.unpaidAmount
                                            .toString(),
                                        readOnly: true,
                                        hintText: AppLocalizations.of(context)!
                                            .global_due,
                                        labelText: AppLocalizations.of(context)!
                                            .open_bills,
                                        suffixText: "DA",
                                        textFormaters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                      )),
                                      SizedBox(
                                        width: paddingXs,
                                      ),
                                      Flexible(
                                        child: CustomTextFormField(
                                          readOnly: true,
                                          initialValue: clientDetailsController
                                              .clientDetails
                                              .value
                                              ?.bill
                                              ?.lastBillAmount
                                              .toString(),
                                          textFormaters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          keyboardType: TextInputType.number,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .last_bill,
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .last_bill,
                                          suffixText: "DA",
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: textfieldsPadding,
                                  ),
                                  CustomTextFormField(
                                    innerPadding: EdgeInsets.symmetric(
                                        horizontal: paddingXs,
                                        vertical: paddingXs),

                                    controller: clientDetailsController
                                        .momTextController,
                                    hintText: AppLocalizations.of(context)!.mom,
                                    // labelText:
                                    //     AppLocalizations.of(context)!.mom,
                                    maxLines: 5,
                                  ),
                                  SizedBox(
                                    height: textfieldsPadding,
                                  ),
                                  Obx(() {
                                    return clientDetailsController.canSaveMom
                                        ? PrimaryButton(
                                            loading: clientDetailsController
                                                .updatingMom.value,
                                            onTap: () async {
                                              bool res =
                                                  await clientDetailsController
                                                      .addMom();
                                              context.pop();
                                            },
                                            text: AppLocalizations.of(context)!
                                                .save,
                                            height: 45,
                                          )
                                        : SizedBox();
                                  })
                                ],
                              ),
                            ),
                          );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
