import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/baddebt_details_controller.dart';
import 'package:sales_master_app/controllers/client_details_controller.dart';
import 'package:sales_master_app/controllers/clients_controller.dart';
import 'package:sales_master_app/widgets/client_card.dart';
import 'package:sales_master_app/widgets/custom_app_drawer.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final ClientsController clientsController = Get.put(ClientsController());
    clientsController.getClients();
    return Scaffold(
      drawer: CustomAppDrawer(),
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Column(
        children: [
          PageDetail(
            title: AppLocalizations.of(context)!.mon_portfeuille,
            bgColor: Theme.of(context).colorScheme.outlineVariant,
            baseviewpage: false,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(paddingXl),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.mon_portfeuille,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 16),
                      ),
                      IntrinsicWidth(
                        child: Obx(() {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: paddingXs),
                                child: Text(
                                  clientsController.onClientsView.value
                                      ? AppLocalizations.of(context)!.clients
                                      : AppLocalizations.of(context)!.badDebt,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                ),
                              ),
                              selectedItemBuilder: (context) {
                                return [
                                  AppLocalizations.of(context)!.clients,
                                  AppLocalizations.of(context)!.badDebt,
                                ].map((view) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: paddingXs),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        view,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                            ),
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              items: [
                                AppLocalizations.of(context)!.clients,
                                AppLocalizations.of(context)!.badDebt,
                              ].map((String view) {
                                return DropdownMenuItem<String>(
                                  value: view,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: paddingXs),
                                    child: Text(
                                      view,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: clientsController.onClientsView.value
                                  ? AppLocalizations.of(context)!.clients
                                  : AppLocalizations.of(context)!.badDebt,
                              onChanged: (String? value) {
                                // if (value != null) {
                                //   clientsController.onClientsView.toggle();
                                // }
                                if (value != null) {
                                  if (value ==
                                      AppLocalizations.of(context)!.clients) {
                                    clientsController.onClientsView.value =
                                        true;
                                    clientsController.getClients();
                                  } else {
                                    clientsController.onClientsView.value =
                                        false;
                                    clientsController.loadBadDebts();
                                  }
                                }
                              },
                              buttonStyleData: ButtonStyleData(
                                // decoration: BoxDecoration(
                                //   color: Theme.of(context)
                                //       .colorScheme
                                //       .outlineVariant,
                                //   border: Border.all(
                                //     color: Theme.of(context)
                                //         .colorScheme
                                //         .tertiaryContainer,
                                //   ),
                                // ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).colorScheme.primary,
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.only(left: 0, right: 8),
                                height: 35,
                                width: double.infinity,
                              ),
                              iconStyleData: IconStyleData(
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 35,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: paddingS,
                  ),
                  CustomTextFormField(
                    login: false,
                    hintText: AppLocalizations.of(context)!
                        .search_msisdn_raison_sociale,
                    prifixIcon: Icon(Icons.search_outlined),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  SizedBox(
                    height: paddingXs,
                  ),
                  Expanded(
                    child: Obx(() {
                      return clientsController.onClientsView.value == true
                          ? ListView.builder(
                              itemCount: clientsController.clients.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: paddingXs),
                                  child: GestureDetector(
                                    onTap: () {
                                      final tag = clientsController
                                          .clients[index].id
                                          .toString();
                                      Get.put(
                                          ClientDetailsController(
                                              client: clientsController
                                                  .clients[index]),
                                          tag: tag);
                                      context.push(AppRoutes.clientDetails.path,
                                          extra: tag);
                                    },
                                    child: ClientCard(
                                        name: clientsController
                                            .clients[index].name,
                                        msisdn: clientsController
                                            .clients[index].msisdnCount,
                                        isActive: clientsController
                                            .clients[index].isActive),
                                  ),
                                );
                              })
                          : ListView.builder(
                              itemCount: clientsController.badDebts.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: paddingXs),
                                  child: GestureDetector(
                                    onTap: () {
                                      final tag = clientsController
                                          .badDebts[index].id
                                          .toString();

                                      Get.put(
                                          BaddebtDetailsController(
                                              baddebt: clientsController
                                                  .badDebts[index]),
                                          tag: tag);

                                      context.push(
                                          AppRoutes.badDebtDetails.path,
                                          extra: tag);
                                    },
                                    child: ClientCard(
                                        name: clientsController
                                            .badDebts[index].companyName,
                                        msisdn: clientsController
                                            .badDebts[index].phoneNumber,
                                        isActive: clientsController
                                            .badDebts[index].isActive),
                                  ),
                                );
                              });
                    }),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
