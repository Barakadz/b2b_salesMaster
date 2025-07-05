import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/deal_status_style.dart';
import 'package:sales_master_app/controllers/deals_controller.dart';
import 'package:sales_master_app/models/deal.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/deal_card.dart';
import 'package:sales_master_app/widgets/my_chip.dart';
import 'package:sales_master_app/widgets/page_detail.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

  Widget mydropdownButton(String status, BuildContext context) {
    StatusStyle style = statusStyles[status] ??
        StatusStyle(
            backgroundColor: Colors.grey.withValues(alpha: 0.3),
            textColor: Colors.grey);
    return Container(
      decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: style.textColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: paddingXs, vertical: paddingXxs),
        child: Text(
          status,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: style.textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DealsController dealsController = Get.find();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PageDetail(
            //title: AppLocalizations.of(context)!.mon_portfeuille,
            title: "Mon Pipeline",
            bgColor: Theme.of(context).colorScheme.outlineVariant,
          ),
          SizedBox(
            height: paddingS,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingL),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("All deals"),
                mydropdownButton("depot d'offre", context)
              ],
            ),
          ),
          SizedBox(
            height: paddingXs,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingL),
            child: CustomTextFormField(
              login: false,
              filled: true,
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              hintText: "Search by Raison sociale/MSISDN",
              prifixIcon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          SizedBox(
            height: paddingS,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingL),
              child: ListView.builder(
                  itemCount: dealsController.deals.length,
                  itemBuilder: (context, index) {
                    Deal deal = dealsController.deals[index];
                    StatusStyle style = statusStyles[deal.status] ??
                        StatusStyle(
                            backgroundColor: Colors.grey.withValues(alpha: 0.4),
                            textColor: Colors.grey);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: paddingXs),
                      child: DealCard(
                        companyName: deal.raisonSociale,
                        interlocuteur: deal.interlocuteur,
                        number: deal.numero,
                        trailingWidget: MyChip(
                            text: deal.status,
                            bgColor: style.backgroundColor,
                            textColor: style.textColor),
                      ),
                    );
                  }),
            ),
          )
        ],
      )),
    );
  }
}
