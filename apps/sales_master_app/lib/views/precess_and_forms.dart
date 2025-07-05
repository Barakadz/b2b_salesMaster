import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/process_and_forms_controller.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/empty_widget.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/process_card.dart';
import 'package:sales_master_app/widgets/process_tab.dart';

class ProcessAndForms extends StatelessWidget {
  const ProcessAndForms({super.key});

  @override
  Widget build(BuildContext context) {
    ProcessAndFormsController controller = Get.put(ProcessAndFormsController());
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
            title: "Process & Formulaires",
            bgColor: Theme.of(context).colorScheme.outlineVariant,
          ),
          SizedBox(
            height: paddingXs,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingL),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nos Procedures / Formulaires",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          SizedBox(
            height: paddingS,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingL),
            child: CustomTextFormField(
              login: false,
              filled: true,
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              hintText: "Search by file name",
              controller: controller.fileSearchController,
              prifixIcon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: paddingM, horizontal: paddingL),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Obx(() {
                    return GestureDetector(
                      onTap: () {
                        controller.switchTabIndex(0);
                      },
                      child: ProcessTab(
                          tabName: "Procédures",
                          clicked: controller.selectedTab.value == 0,
                          svgPath: "assets/process.svg"),
                    );
                  }),
                ),
                SizedBox(
                  width: paddingS,
                ),
                Expanded(
                  child: Obx(() {
                    return GestureDetector(
                      onTap: () {
                        controller.switchTabIndex(1);
                      },
                      child: ProcessTab(
                          tabName: "Formulaires",
                          clicked: controller.selectedTab.value == 1,
                          svgPath: "assets/form.svg"),
                    );
                  }),
                )
              ],
            ),
          ),
          SizedBox(
            height: paddingS,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingL),
              child: Obx(() {
                return controller.selectedTab.value == 0
                    ? controller.loadingProcess.value == true
                        ? Center(child: LoadingIndicator())
                        : controller.processFiles.isEmpty
                            ? EmptyWidget(
                                title: "Aucun fichier disponible",
                                description:
                                    "Il n’y a pas de fichier pour cette catégorie pour le moment.",
                              )
                            : ListView.builder(
                                itemCount: controller.processFiles.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: paddingXs),
                                    child: ProcessCard(
                                      file: controller.processFiles[index],
                                    ),
                                  );
                                })
                    : controller.loadingForms.value == true
                        ? Center(child: LoadingIndicator())
                        : controller.formsFiles.isEmpty
                            ? EmptyWidget(
                                title: "Aucun fichier disponible",
                                description:
                                    "Il n’y a pas de fichier pour cette catégorie pour le moment.",
                              )
                            : ListView.builder(
                                itemCount: controller.formsFiles.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: paddingXs),
                                    child: ProcessCard(
                                      file: controller.formsFiles[index],
                                    ),
                                  );
                                });
              }),
            ),
          )
        ],
      )),
    );
  }
}
