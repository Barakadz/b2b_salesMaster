import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/realisations_controller.dart';
import 'package:sales_master_app/models/realisation.dart';
import 'package:sales_master_app/realisation_chart_container.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/realisation_overview_container.dart';

class RealisationScreen extends StatelessWidget {
  const RealisationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RealisationsController realisationsController =
        Get.put(RealisationsController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageDetail(
            title: "Réalisations Trimestrielles",
            bgColor: Theme.of(context).colorScheme.outlineVariant,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: paddingM, horizontal: paddingL),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Mes réalisations",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Obx(() {
                          return realisationsController
                                      .loadingRealisations.value ==
                                  true
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(left: paddingXxs),
                                  child: LoadingIndicator(),
                                )
                              : SizedBox();
                        }),
                        Spacer(),
                        Obx(() {
                          return Switch(
                            value: realisationsController.showRealisation.value,
                            onChanged: (value) {
                              realisationsController.toggleShowRealisation();
                            },
                            activeColor:
                                Theme.of(context).colorScheme.outlineVariant,
                            activeTrackColor: Color(0Xff53DAA0),
                          );
                        })
                      ],
                    ),
                    SizedBox(
                      height: paddingXs,
                    ),
                    Obx(() {
                      return RealisationChartContainer(
                        disabled: !realisationsController
                                    .showRealisation.value ==
                                true ||
                            realisationsController.loadingRealisations.value ==
                                true,
                        date: "March 2025",
                        gloabl: true,
                        totalTarget: realisationsController.getTotalTarget(),
                        totalrealised:
                            realisationsController.getTotalRealisations(),
                        totalRealisations:
                            realisationsController.totalRealisations.value ??
                                TotalRealisation(increase: 0, realisations: []),
                      );
                    }),
                    SizedBox(
                      height: paddingS,
                    ),
                    Obx(() {
                      return RealisationOverviewContainer(
                          totalRealisation: realisationsController
                                  .totalRealisations.value ??
                              TotalRealisation(increase: 0, realisations: []),
                          totalrealised:
                              realisationsController.getTotalRealisations(),
                          totalTarget: realisationsController.getTotalTarget(),
                          loading:
                              realisationsController.loadingRealisations.value,
                          disabled:
                              !realisationsController.showRealisation.value);
                    })
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
