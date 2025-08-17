import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/realisations_controller.dart';
import 'package:sales_master_app/models/realisation.dart';
import 'package:sales_master_app/realisation_chart_container.dart';
import 'package:sales_master_app/widgets/custom_app_drawer.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/realisation_overview_container.dart';

class RealisationScreen extends StatelessWidget {
  const RealisationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RealisationsController realisationsController =
        Get.put(RealisationsController());
    realisationsController.loadRealisation();
    final PageController pageController =
        PageController(viewportFraction: 0.96);
    return Scaffold(
      drawer: CustomAppDrawer(),
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
            baseviewpage: false,
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
                    // Row(
                    //   mainAxisSize: MainAxisSize.max,
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       "Mes réalisations",
                    //       style: Theme.of(context).textTheme.titleMedium,
                    //     ),
                    //     Obx(() {
                    //       return realisationsController
                    //                   .loadingRealisations.value ==
                    //               true
                    //           ? Padding(
                    //               padding:
                    //                   const EdgeInsets.only(left: paddingXxs),
                    //               child: LoadingIndicator(),
                    //             )
                    //           : SizedBox();
                    //     }),
                    //     Spacer(),
                    //     Obx(() {
                    //       return Switch(
                    //         value: realisationsController.showRealisation.value,
                    //         onChanged: (value) {
                    //           realisationsController.toggleShowRealisation();
                    //         },
                    //         activeColor:
                    //             Theme.of(context).colorScheme.outlineVariant,
                    //         activeTrackColor: Color(0Xff53DAA0),
                    //       );
                    //     })
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: paddingXs,
                    // ),
                    Obx(() {
                      final List<Widget> chartItems = [];

                      chartItems.add(Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: paddingXxs),
                        child: RealisationChartContainer(
                            date:
                                "${realisationsController.selectedQuarter.value} ${DateTime.now().year}",
                            gloabl: true,
                            disabled: realisationsController
                                        .showRealisation.value ==
                                    false ||
                                realisationsController
                                        .loadingRealisations.value ==
                                    true,
                            totalrealised: realisationsController
                                .getTotalRealisations(),
                            totalTarget: realisationsController
                                .getTotalTarget(),
                            totalRealisations: realisationsController
                                    .totalRealisations.value ??
                                TotalRealisation(
                                    trimester: realisationsController
                                        .selectedQuarter.value,
                                    year: DateTime.now().year.toString(),
                                    assignedTo: 1,
                                    increase: realisationsController
                                            .totalRealisations
                                            .value
                                            ?.increase ??
                                        0,
                                    realisations: [])),
                      ));

                      for (Realisation realisation in realisationsController
                              .totalRealisations.value?.realisations ??
                          []) {
                        chartItems.add(Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingXxs),
                          child: RealisationChartContainer(
                              date:
                                  "${realisationsController.selectedQuarter.value} ${DateTime.now().year}",
                              gloabl: false,
                              totalrealised: realisation.currentValue,
                              totalTarget: realisation.target,
                              totalRealisations: TotalRealisation(
                                  trimester:
                                      "${realisationsController.selectedQuarter.value}",
                                  year: realisationsController.year,
                                  assignedTo: 1,
                                  increase: realisationsController.totalRealisations.value?.increase ?? 0,
                                  realisations: [realisation])),
                        ));
                      }

                      return ExpandablePageView(
                        children: chartItems,
                        controller: pageController,
                        clipBehavior: Clip.none,
                      );
                    }),
                    SizedBox(
                      height: paddingS,
                    ),
                    Obx(() {
                      return RealisationOverviewContainer(
                          totalRealisation:
                              realisationsController.totalRealisations.value ??
                                  TotalRealisation(
                                      trimester: realisationsController
                                          .selectedQuarter.value,
                                      year: realisationsController.year,
                                      assignedTo: 1,
                                      increase: 0,
                                      realisations: []),
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
