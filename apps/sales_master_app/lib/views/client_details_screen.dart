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
import 'package:sales_master_app/widgets/snackbarWidget.dart';

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
              title: "mon_portfeuille".tr,
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
                                    "gestion_portefeuille".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: formSectionTopPadding,
                                  ),
                                   Text(
                                    "prodil_client".tr,
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
                                    hintText: "raison_sociale".tr,
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
                                    hintText: "nom_telecom_manager".tr,
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
                                                          "modifier_telecom_manager"
                                                              .tr,
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
                                                          "enter_email".tr,
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
                                                                        "mail"
                                                                            .tr,
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
                                                          "edit_manager_hint"
                                                              .tr,
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
                                                                          SnackBarHelper.showSuccess("Succès","successUpdateMail".tr);

                                                                  context.pop();
                                                                }
                                                              },
                                                              text:
                                                                  "envoyer".tr);
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
                                    "details_abonnement".tr,
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
                                    hintText: "nombre_lignes".tr,
                                    labelText: "nombre_lignes".tr,
                                  ),
                                  SizedBox(
                                    height: textfieldsPadding,
                                  ),
                               Text('Les Offres :'), 
                                 ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: clientDetailsController.clientDetails.value?.allOffers.length ?? 0,
  itemBuilder: (context, index) {
    final offer =
        clientDetailsController.clientDetails.value!.allOffers[index];

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// ICON
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.local_offer_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.packageCode,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  offer.packageId != null
                      ? "ID : ${offer.packageId}"
                      : "Sans identifiant",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),

          
        ],
      ),
    );
  },
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
                                          hintText: "expiration_date".tr,
                                          initialValue: clientDetailsController
                                              .clientDetails
                                              .value
                                              ?.expiryDateTop1000,
                                          labelText: "expiration_date".tr,
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
                                    "etat_financier".tr,
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
                                    hintText: "revenus_mensuels".tr,
                                    labelText: "revenus_mensuels".tr,
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
                                    hintText: "open_bills".tr,
                                    labelText: "open_bills".tr,
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
                                        hintText: "global_due".tr,
                                        labelText: "open_bills".tr,
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
                                          hintText: "last_bill".tr,
                                          labelText: "last_bill".tr,
                                          suffixText: "DA",
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: textfieldsPadding,
                                  ),
                               CustomTextFormField(
  controller: clientDetailsController.lastVisitDateController,
  readOnly: true,
  hintText: "last_visit_date".tr,
  labelText: "last_visit_date".tr,
  suffixIcon: Icon(Icons.calendar_today_outlined),
  onTap: () async {
    await clientDetailsController.pickDateTime(isNextDate: false);
  },
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
                                    hintText: "mom".tr,
                                    // labelText:
                                    //     "mom".tr,
                                    maxLines: 5,
                                  ),
                                  SizedBox(
                                    height: textfieldsPadding,
                                  ),
                                  
                                    PrimaryButton(
                                            loading: clientDetailsController
                                                .updatingMom.value,
                                            onTap: () async {
                                              bool res =
                                                  await clientDetailsController
                                                      .addMom();
                                              context.pop();
                                            },
                                            text: "save".tr,
                                            height: 45,
                                          )
                                    
                                   
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
