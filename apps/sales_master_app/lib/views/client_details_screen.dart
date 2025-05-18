import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/clients_controller.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/primary_button.dart';

class ClientDetailsScreen extends StatelessWidget {
  final ClientsController clientsController = Get.put(ClientsController());
  ClientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(paddingXl),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageDetail(title: "Mon Portefeuile"),
                SizedBox(
                  height: paddingXl,
                ),
                Text(
                  "Gestion de mon portefeuile",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: formSectionTopPadding,
                ),
                Text(
                  "PROFIL CLIENT",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: formSectionBottomPadding,
                ),
                CustomTextFormField(
                  hintText: "Raison Sociale*",
                  filled: false,
                ),
                SizedBox(
                  height: textfieldsPadding,
                ),
                CustomTextFormField(
                  hintText: "Nom Télecom Manager",
                  filled: false,
                  suffixIcon: Icon(
                    Icons.border_color_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  height: formSectionTopPadding,
                ),
                Text(
                  "DÉTAILS DE L'ABONNEMENT",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: formSectionBottomPadding,
                ),
                CustomTextFormField(
                  hintText: "Nombre lignes",
                ),
                SizedBox(
                  height: textfieldsPadding,
                ),
                CustomTextFormField(
                  hintText: "Offres",
                ),
                SizedBox(
                  height: textfieldsPadding,
                ),
                CustomTextFormField(
                  hintText: "Reconduction",
                ),
                SizedBox(
                  height: textfieldsPadding,
                ),
                CustomTextFormField(
                  hintText: "Date d'expiration",
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
                  "ÉTAT FINANCIER",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: formSectionBottomPadding,
                ),
                CustomTextFormField(
                  hintText: "Revenu annuel",
                ),
                SizedBox(
                  height: textfieldsPadding,
                ),
                CustomTextFormField(
                  hintText: "Nombre de factures ouvertes",
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
                      hintText: "Montant d'impayés",
                      suffixText: "DA",
                      textFormaters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                    )),
                    SizedBox(
                      width: paddingXs,
                    ),
                    Flexible(
                      child: CustomTextFormField(
                        textFormaters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        hintText: "Montant de la derniere facture",
                        suffixText: "DA",
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: textfieldsPadding,
                ),
                CustomTextFormField(
                  hintText: "MOM",
                  maxLines: 5,
                ),
                SizedBox(
                  height: textfieldsPadding,
                ),
                PrimaryButton(
                  onTap: () {},
                  text: "Enregistrer",
                  height: 45,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
