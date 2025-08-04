import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/deal_status_style.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/deal_details_controller.dart';
import 'package:sales_master_app/controllers/deals_controller.dart';
import 'package:sales_master_app/controllers/pipeline_controller.dart';
import 'package:flutter/material.dart';
import 'package:sales_master_app/models/deal.dart';
import 'package:sales_master_app/widgets/custom_app_drawer.dart';
import 'package:sales_master_app/widgets/deal_card.dart';
import 'package:sales_master_app/widgets/my_chip.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/pipeline_chart.dart';
import 'package:sales_master_app/widgets/pipeline_container.dart';
import 'package:sales_master_app/widgets/primary_button.dart';

class PipelineMainPage extends StatelessWidget {
  final PipelineController pipelineController = Get.put(PipelineController());
  PipelineMainPage({super.key});

  Widget errorWidget() {
    return Column(
      children: [
        Text("could not load pipeline"),
        PrimaryButton(
            onTap: () {
              pipelineController.fetchFakePipeline();
            },
            text: "Try again")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DealsController dealsController = Get.put(DealsController());
    return Scaffold(
      drawer: CustomAppDrawer(),
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageDetail(
              title: "Mon Pipeline",
              baseviewpage: false,
            ),
            SizedBox(
              height: paddingL,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: paddingL),
                  child: Column(
                    children: [
                      Obx(() {
                        return PipelineContainer(
                          loading: pipelineController.loadingPipeline.value,
                          errorWidget: Container(),
                          error: pipelineController.errorLoadingPipeline.value,
                          globalValue:
                              pipelineController.myPipeLine.value?.performance,
                          child: PipelineChart(
                            stats: pipelineController.myPipeLine.value?.stats ??
                                [],
                          ),
                        );
                      }),
                      SizedBox(
                        height: paddingM,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Derniers Deals",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.push(AppRoutes.dealsScreen.path);
                            },
                            child: Text("All deals",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: paddingS,
                      ),
                      Container(
                        constraints: BoxConstraints(minHeight: 200),
                        child: Obx(() {
                          return dealsController.loadingDeals.value == true
                              ? Container(
                                  height: 10,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                )
                              : dealsController.errorLoadingDeals.value == true
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("failed to load deals"),
                                        PrimaryButton(
                                            onTap: () {
                                              dealsController.loadingDeals();
                                            },
                                            text: "try again")
                                      ],
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: paddingXs,
                                      children: (dealsController.paginatedDeals
                                                  .value?.deals ??
                                              [])
                                          .take(2)
                                          .map<Widget>((Deal deal) {
                                        StatusStyle style = statusStyles[
                                                deal.status.toLowerCase()] ??
                                            StatusStyle(
                                                backgroundColor: Colors.grey
                                                    .withValues(alpha: 0.3),
                                                textColor: Colors.grey);
                                        return GestureDetector(
                                          onTap: () {
                                            Get.put(DealDetailsController());
                                            context.push(
                                                AppRoutes.dealDetails.path,
                                                extra: deal);
                                          },
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
                                      }).toList(),
                                    );
                        }),
                      ),
                      SizedBox(
                        height: paddingS,
                      ),
                      PrimaryButton(
                          onTap: () {
                            Get.put(DealDetailsController());

                            context.push(AppRoutes.dealDetails.path);
                          },
                          text: "Ajouter Deal"),
                      SizedBox(
                        height: paddingL,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
