import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/clients_controller.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClientDetailsScreen extends StatelessWidget {
  final ClientsController clientsController = Get.put(ClientsController());
  ClientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            PageDetail(title: AppLocalizations.of(context)!.mon_portfeuille),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(paddingXl),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.gestion_portefeuille,
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
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                        hintText: AppLocalizations.of(context)!.raison_sociale,
                        filled: false,
                      ),
                      SizedBox(
                        height: textfieldsPadding,
                      ),
                      CustomTextFormField(
                        hintText:
                            AppLocalizations.of(context)!.nom_telecom_manager,
                        filled: false,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            // Get.dialog(Container(
                            //   constraints: BoxConstraints(maxWidth: 350),
                            //   decoration: BoxDecoration(
                            //       color: Theme.of(context).colorScheme.surface),
                            //   child: Column(
                            //     children: [Text("dialog")],
                            //   ),
                            // ));
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
                                              BorderRadius.circular(12)),
                                      constraints:
                                          BoxConstraints(maxWidth: 350),
                                      child: Padding(
                                        padding: const EdgeInsets.all(paddingL),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              AppLocalizations.of(context)!
                                                  .modifier_telecom_manager,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: paddingXxs,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .enter_email,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant
                                                          .withValues(
                                                              alpha: 0.5),
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: paddingS,
                                            ),
                                            Material(
                                              child: CustomTextFormField(
                                                customTextField: true,
                                                innerPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                        vertical: 0),
                                                prifixIcon: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          right: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .outline))),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: paddingS),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.mail_sharp,
                                                          color:
                                                              Theme.of(context)
                                                                  .dividerColor,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: paddingXs,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .mail,
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
                                                                              0.15),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 14),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: paddingXxs,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .edit_manager_hint,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant
                                                          .withValues(
                                                              alpha: 0.25),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: paddingXxl,
                                            ),
                                            PrimaryButton(
                                                height: 45,
                                                onTap: () {},
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .envoyer)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                          },
                          child: Icon(
                            Icons.border_color_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: formSectionTopPadding,
                      ),
                      Text(
                        AppLocalizations.of(context)!.details_abonnement,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                        hintText: AppLocalizations.of(context)!.nombre_lignes,
                      ),
                      SizedBox(
                        height: textfieldsPadding,
                      ),
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.offres,
                      ),
                      SizedBox(
                        height: textfieldsPadding,
                      ),
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.reconduction,
                      ),
                      SizedBox(
                        height: textfieldsPadding,
                      ),
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.expiration_date,
                        filled: false,
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(
                        height: formSectionTopPadding,
                      ),
                      Text(
                        AppLocalizations.of(context)!.etat_financier,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                        hintText: AppLocalizations.of(context)!.revenu_annuel,
                      ),
                      SizedBox(
                        height: textfieldsPadding,
                      ),
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.open_bills,
                      ),
                      SizedBox(
                        height: textfieldsPadding,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              child: CustomTextFormField(
                            hintText: AppLocalizations.of(context)!.global_due,
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
                              textFormaters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              hintText: AppLocalizations.of(context)!.last_bill,
                              suffixText: "DA",
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: textfieldsPadding,
                      ),
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.mom,
                        maxLines: 5,
                      ),
                      SizedBox(
                        height: textfieldsPadding,
                      ),
                      PrimaryButton(
                        onTap: () {},
                        text: AppLocalizations.of(context)!.save,
                        height: 45,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
