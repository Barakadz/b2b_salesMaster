import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/clients_controller.dart';
import 'package:sales_master_app/models/client.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/debt_tile.dart';
import 'package:sales_master_app/widgets/info_container.dart';
import 'package:sales_master_app/widgets/my_chip.dart';
import 'package:sales_master_app/widgets/note.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BadDebtDetails extends StatelessWidget {
  final Client clientinDebt;
  final ClientsController clientsController = Get.find();

  BadDebtDetails({super.key, required this.clientinDebt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageDetail(title: AppLocalizations.of(context)!.my_baddebt),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
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
                    CustomTextFormField(
                      prifixIcon: Icon(
                        Icons.search_outlined,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withValues(alpha: 0.15),
                      ),
                      hintText: AppLocalizations.of(context)!.raison_sociale,
                      filled: true,
                      login: false,
                    ),
                    SizedBox(
                      height: formSectionTopPadding,
                    ),
                    Text(
                      AppLocalizations.of(context)!.generale_informations,
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
                    InfoContainer(
                      label: AppLocalizations.of(context)!.raison_sociale,
                      content: clientinDebt.companyName,
                      status: MyChip(
                          text: AppLocalizations.of(context)!.call,
                          bgColor: clientActiveColors[true]["bgColor"],
                          textColor: clientActiveColors[true]["textColor"]),
                    ),
                    SizedBox(
                      height: textfieldsPadding,
                    ),
                    InfoContainer(
                      label: AppLocalizations.of(context)!.number,
                      content: "+213 ${clientinDebt.msisdn}",
                      icon: Icon(
                        Icons.phone_sharp,
                        size: 20,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withValues(alpha: 0.15),
                      ),
                    ),
                    SizedBox(
                      height: formSectionTopPadding,
                    ),
                    Text(
                      AppLocalizations.of(context)!.bills_data,
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
                    InfoContainer(
                      label: AppLocalizations.of(context)!.nombre_lignes,
                      content:
                          "${clientinDebt.msisdnCount} ${AppLocalizations.of(context)!.lignes}",
                    ),
                    SizedBox(
                      height: formSectionTopPadding,
                    ),
                    InfoContainer(
                      label: AppLocalizations.of(context)!.open_bills,
                      content: "${clientinDebt.openBills}",
                    ),
                    SizedBox(
                      height: formSectionTopPadding,
                    ),
                    Text(
                      AppLocalizations.of(context)!.montant_financier,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: paddingXxs,
                          children: [
                            DebtTile(
                              prefix: SvgPicture.asset(
                                "assets/payment_icon.svg",
                                height: 14,
                                width: 14,
                              ),
                              label: AppLocalizations.of(context)!.last_bill,
                              content: clientinDebt.lastBill.toString(),
                            ),
                            DebtTile(
                              label: AppLocalizations.of(context)!.global_due,
                              content: clientinDebt.totalUnpaid.toString(),
                            ),
                            DebtTile(
                              prefix: Icon(
                                Icons.circle,
                                color: Colors.orange,
                                size: 14,
                              ),
                              label:
                                  AppLocalizations.of(context)!.gloabl_due_aj,
                              content: clientinDebt.globalDueAj.toString(),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: paddingXxxl,
                    ),
                    Note(info: AppLocalizations.of(context)!.contacted_warning),
                    SizedBox(
                      height: paddingS,
                    ),
                    Container(
                        width: double.infinity,
                        child: PrimaryButton(
                          onTap: () {},
                          text: AppLocalizations.of(context)!.call,
                          height: 45,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
