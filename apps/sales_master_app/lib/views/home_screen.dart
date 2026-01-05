import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/currentuser_controller.dart';
import 'package:sales_master_app/controllers/drawer_controller.dart';
import 'package:sales_master_app/controllers/outlook_controller.dart';
import 'package:sales_master_app/controllers/pipeline_controller.dart';
import 'package:sales_master_app/controllers/realisations_controller.dart';
import 'package:sales_master_app/controllers/tab_controller.dart';
import 'package:sales_master_app/models/realisation.dart';
import 'package:sales_master_app/realisation_chart_container.dart';
import 'package:sales_master_app/services/date_formatter_service.dart';
import 'package:sales_master_app/services/push_notification_service.dart';
import 'package:sales_master_app/widgets/custom_app_drawer.dart';
import 'package:sales_master_app/widgets/empty_widget.dart';
import 'package:sales_master_app/widgets/error_widget.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';
import 'package:sales_master_app/widgets/outlook_relainder_card.dart';
import 'package:sales_master_app/widgets/salary_note.dart';
import 'package:sales_master_app/widgets/second_pipeline_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Widget outlookFilterTab(bool selected, BuildContext context, String tabName) {
    return selected == true
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: paddingXxs, horizontal: paddingS),
              child: Text(
                tabName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.03),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: paddingXxs, horizontal: paddingS),
              child: Text(
                tabName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.25)),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final dateService = DateFormatterService();
    final now = DateTime.now();
    RealisationsController realisationsController =
        Get.put(RealisationsController());
    PipelineController pipelineController = Get.put(PipelineController());
    OutlookController outlookController = Get.put(OutlookController());
    final TabControllerImp controller = Get.put(TabControllerImp());
    final PageController pageControllerr = PageController();
  final PageController pageController =
    PageController(viewportFraction: 0.96);

    return Scaffold(
      drawer: CustomAppDrawer(),
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: 450,
            //color: Theme.of(context).colorScheme.primary,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0xffFF6B81),
                  Color(0xffDD2A45),
                ],
                center: Alignment.center,
                radius: 0.8,
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                "assets/circle.svg",
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.all(paddingL),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: paddingS,
                      children: [
                        Builder(builder: (ctx) {
                          return GestureDetector(
                            onTap: () {
                              Get.find<CustomDrawerController>()
                                  .openDrawer(ctx, baseview: false);
                            },
                            child: Icon(
                              Icons.density_medium,
                              size: 26,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          );
                        }),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              CurrentuserController userController =
                                  Get.put(CurrentuserController());
                              String? userName =
                                  userController.currentUser.value?.firstName;
                              return Text(
                                "Morning, ${userName ?? ''}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              );
                            }),
                            Text(
                              dateService.format(now, locale: 'en'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withValues(alpha: 0.7)),
                            )
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.push(AppRoutes.notification.path);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withValues(alpha: 0.3)),
                            child: Padding(
                              padding: const EdgeInsets.all(paddingS),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/notification_bell.svg",
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.all(paddingL),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: paddingM,
                          children: [
                            Obx(() {
                              return (realisationsController.totalRealisations
                                              .value?.increase ??
                                          0) >
                                      0
                                  ? Column(
                                    children: [
                                     (realisationsController.totalRealisations.value?.increaseResult ?? 0.0) > 70.0
    ? SalaryNote(
        prefixSvgPath: "assets/congrat_left.svg",
        suffixSvgPath: "assets/congrat_right.svg",
        raise: realisationsController.totalRealisations.value?.increase ?? 0,
      )
    : SizedBox()                                       
                                    ],
                                  )
                                  : SizedBox();
                            }),
                          
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blueGrey.shade100),
                                color: Colors.blueGrey.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // ---- TAB BAR ----
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      double tabWidth =
                                          (constraints.maxWidth - 12) / 2;
                                      return TabBar(
                                        controller: controller.tabController,
                                        isScrollable: false,
                                        labelColor: Colors.black,
                                        unselectedLabelColor:
                                            Colors.blueGrey.shade200,
                                        indicatorColor: Colors.transparent,
                                        dividerColor: Colors.transparent,
                                        indicator: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blueGrey.shade100),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        labelPadding: EdgeInsets.zero,
                                        onTap: (index) {
                                          pageController.animateToPage(
                                            index,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        tabs: [
                                          Tab(
                                            child: SizedBox(
                                              width: tabWidth,
                                              child:   Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.0,
                                                    vertical: 4.0),
                                                child: Text(
                                                  "realisation_total".tr,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: SizedBox(
                                              width: tabWidth,
                                              child:   Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.0,
                                                    vertical: 4.0),
                                                child: Text(
                                                  "dealTotal".tr,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                             ExpandablePageView(
                              controller: pageController,
                              onPageChanged: (index) {
                                controller.tabController.animateTo(index);
                              },
                              children: [
                                Obx(() {
                                  final List<Widget> chartItems = [];

                                  chartItems.add(
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: paddingXxs),
                                      child: RealisationChartContainer(
                                        pageTitle: 'HomePage'.tr,
                                        date:
                                            "${realisationsController.selectedQuarter.value} ${DateTime.now().year}",
                                        gloabl: true,
                                        disabled: realisationsController
                                                    .showRealisation.value ==
                                                false ||
                                            realisationsController
                                                    .loadingRealisations
                                                    .value ==
                                                true,
                                        totalrealised: realisationsController
                                            .getTotalRealisations(),
                                        totalTarget: realisationsController
                                            .getTotalTarget(),
                                            pct_realisation:realisationsController.totalRealisations.value?.increaseResult ,
                                        totalRealisations:
                                            realisationsController
                                                    .totalRealisations.value ??
                                                TotalRealisation(
                                                  trimester:
                                                      realisationsController
                                                          .selectedQuarter
                                                          .value,
                                                  year: DateTime.now()
                                                      .year
                                                      .toString(),
                                                  assignedTo: 1,
                                                  increase:
                                                      2222222 ,
                                                  realisations: [],
                                                ),
                                      ),
                                    ),
                                  );

                                  return realisationsController
                                              .loadingRealisations.value ==
                                          true
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : Column(children: chartItems);
                                }),
                                  Obx(() {
                                  return pipelineController
                                              .loadingPipeline.value ==
                                          true
                                      ? SizedBox(
                                          height: 250,
                                          width: double.infinity,
                                          child:
                                              Center(child: LoadingIndicator()),
                                        )
                                      : pipelineController
                                                  .errorLoadingPipeline.value ==
                                              true
                                          ? CustomErrorWidget(
                                              onTap: () {
                                                pipelineController
                                                    .fetchPipeLine();
                                              },
                                            )
                                          : SecondPipelineContainer(
                                              globalValue: pipelineController
                                                  .myPipeLine
                                                  .value
                                                  ?.performance,
                                              selectedStatusIndex:
                                                  pipelineController
                                                      .selectedPipelineStatusIndex
                                                      .value,
                                              loading: false,
                                              error: pipelineController
                                                  .errorLoadingPipeline.value,
                                              errorWidget: Container(),
                                              pipelinePerformance:
                                                  pipelineController
                                                          .myPipeLine.value ??
                                                      pipelineController
                                                          .emptyPipelinePerformance,
                                              onStatusSelected:
                                                  pipelineController
                                                      .switchStatusInedx,
                                            );
                                }),
                              ],
                            ),
                             //  Obx(() {
                            //   return RealisationOverviewContainer(
                            //       overview: false,
                            //       mini: true,
                            //       showSummary: true,
                            //       totalRealisation: realisationsController
                            //               .totalRealisations.value ??
                            //           TotalRealisation(
                            //               trimester: "Q3",
                            //               year: "2025",
                            //               assignedTo: 1,
                            //               increase: 0,
                            //               realisations: []),
                            //       totalrealised: realisationsController
                            //           .getTotalRealisations(),
                            //       totalTarget:
                            //           realisationsController.getTotalTarget(),
                            //       loading: realisationsController
                            //           .loadingRealisations.value,
                            //       disabled: realisationsController
                            //               .totalRealisations.value ==
                            //           null);
                            // }),
                             Obx(() {
                              return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: paddingS,
                                  children: List.generate(
                                      outlookController.tabs.length, (index) {
                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          outlookController.switchTab(index);
                                        },
                                        child: outlookFilterTab(
                                            index ==
                                                outlookController
                                                    .tabIndex.value,
                                            context,
                                            outlookController.tabs[index]),
                                      ),
                                    );
                                  }));
                            }),
                            Obx(() {
                              return outlookController.loadingOutlook.value ==
                                      true
                                  ? SizedBox(
                                      height: 250,
                                      width: double.infinity,
                                      child: Center(child: LoadingIndicator()))
                                  : outlookController.outlookError.value == true
                                      ? CustomErrorWidget(
                                          onTap: () {
                                            outlookController.fetchReminders();
                                          },
                                        )
                                      : outlookController.reminders.isEmpty
                                          ? Center(
                                              child: EmptyWidget(
                                                title: "noReminders".tr,
                                                description:
                                                    "noRemindersDesc".tr,
                                              ),
                                            )
                                          : Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              spacing: paddingS,
                                              children: List.generate(
                                                  outlookController.reminders
                                                      .length, (index) {
                                                return OutlookRemainderCard(
                                                  reminder: outlookController
                                                      .reminders[index],
                                                  index: index + 1,
                                                  count: outlookController
                                                      .reminders.length,
                                                );
                                              }).toList());
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
