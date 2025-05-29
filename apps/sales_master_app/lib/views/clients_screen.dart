import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/clients_controller.dart';
import 'package:sales_master_app/widgets/client_card.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClientsScreen extends StatelessWidget {
  final ClientsController clientsController = Get.put(ClientsController());
  ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    clientsController.getClients();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Column(
        children: [
          PageDetail(
            title: AppLocalizations.of(context)!.mon_portfeuille,
            bgColor: Theme.of(context).colorScheme.outlineVariant,
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
                      GestureDetector(
                        onTap: clientsController.switchiew,
                        child: Container(
                          width: 81,

                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius:
                                  BorderRadius.circular(borderRadiusSmall)),
                          //child: PrimaryButton(onTap: () {}, text: "clients")
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(paddingXxs),
                            child: Text(
                              AppLocalizations.of(context)!.clients,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                            ),
                          )),
                        ),
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.my_clients,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withValues(alpha: 0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        AppLocalizations.of(context)!.view_all,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: paddingXs,
                  ),
                  Expanded(
                    child: Obx(() {
                      return clientsController.on_clients_view.value == true
                          ? ListView.builder(
                              itemCount: clientsController.clients.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: paddingXs),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.push(
                                        AppRoutes.clientDetails.path,
                                      );
                                    },
                                    child: ClientCard(
                                        name: clientsController
                                            .clients[index].companyName,
                                        msisdn: clientsController
                                            .clients[index].msisdn,
                                        isActive: clientsController
                                            .clients[index].active),
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
                                      context.push(
                                          AppRoutes.badDebtDetails.path,
                                          extra: clientsController
                                              .badDebts[index]);
                                    },
                                    child: ClientCard(
                                        name: clientsController
                                            .badDebts[index].companyName,
                                        msisdn: clientsController
                                            .badDebts[index].msisdn,
                                        isActive: clientsController
                                            .badDebts[index].active),
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
