import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:sales_master_app/widgets/error_widget.dart';
import 'package:sales_master_app/widgets/my_chip.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/pipeline_chart.dart';
import 'package:sales_master_app/widgets/pipeline_container.dart';
import 'package:sales_master_app/widgets/primary_button.dart';

class PipelineMainPage extends StatelessWidget {
  final PipelineController pipelineController = Get.put(PipelineController());
  PipelineMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    DealsController dealsController = Get.put(DealsController());
Widget formTitle(
      {required String svgName,
      required String title,
      required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(svgName),
        SizedBox(
          width: paddingXs,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
        )
      ],
    );
  }
    return Scaffold(
      drawer: CustomAppDrawer(),
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageDetail(
              title: "mon_pipeline".tr,
              baseviewpage: false,
            ),
            SizedBox(height: paddingL),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: paddingL),
                  child: Column(
                    children: [
                      GestureDetector(
                            onTap: () {
                          Get.put(DealDetailsController());
                          context.push(AppRoutes.dealDetails.path);
                            },
                            child:  formTitle(
                          svgName: "assets/add_deal.svg",
                          title: "Add New Deal",
                          context: context),
                          ),
                       SizedBox(height: paddingL),
                      // Pipeline Chart Section
                      Obx(() {
                        return PipelineContainer(
                          loading: pipelineController.loadingPipeline.value,
                          errorWidget: CustomErrorWidget(
                            onTap: () {
                              pipelineController.fetchPipeLine();
                            },
                          ),
                          error: pipelineController.errorLoadingPipeline.value,
                          globalValue:
                              pipelineController.myPipeLine.value?.performance,
                          child: PipelineChart(
                            stats:
                                pipelineController.myPipeLine.value?.stats ?? [],
                          ),
                        );
                      }),
                      SizedBox(height: paddingM),

                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
IntrinsicWidth(
  child: DropdownButtonHideUnderline(
    child: Obx(() {
      final selected = dealsController.selectedDealFilter.value;
      final style = statusStyles[selected.toLowerCase()] ??
          StatusStyle(
            backgroundColor: Colors.grey.withAlpha(40),
            textColor: Colors.grey,
          );

      // On filtre "empty" pour ne pas l'afficher dans le menu
      final filteredStatus = dealsController.dealsStatusFilters
          .where((key) => key != 'empty')
          .toList();

      return DropdownButton2<String>(
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingXs),
          child: Text(
            'type'.tr,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        selectedItemBuilder: (BuildContext context) {
          return filteredStatus.map((String item) {
            final style = statusStyles[item.toLowerCase()] ??
                StatusStyle(
                  backgroundColor: Colors.grey.withAlpha(40),
                  textColor: Colors.grey,
                );
            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: paddingXs),
                child: Text(
                  item,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: style.textColor),
                ),
              ),
            );
          }).toList();
        },
        items: filteredStatus.map((String key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingXs),
              child: Text(
                key,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          );
        }).toList(),
        value: dealsController.selectedDealFilter.value != 'empty'
            ? dealsController.selectedDealFilter.value
            : null, // si "empty", on met null
        onChanged: (String? key) {
          if (key != null &&
              key != dealsController.selectedDealFilter.value) {
            dealsController.selectedDealFilter.value = key;
            dealsController.filterDeals(key);
          }
        },
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.circular(borderRadiusSmall),
            border: Border.all(
              color: style.textColor,
            ),
          ),
          padding: const EdgeInsets.only(left: 0, right: 8),
          height: 35,
          width: double.infinity,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 35,
          padding: EdgeInsets.zero,
        ),
      );
    }),
  ),
),

                          GestureDetector(
                            onTap: () {
                              context.push(AppRoutes.dealsScreen.path);
                            },
                            child: Text(
                              "AffichageAll".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: paddingS),
                       // Deals List (filtered and only 2)
                      Obx(() {
                        if (dealsController.loadingDeals.value) {
                          return Container(
                            constraints: BoxConstraints(minHeight: 200),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                                strokeWidth: 3,
                              ),
                            ),
                          );
                        }

                        if (dealsController.errorLoadingDeals.value) {
                          return CustomErrorWidget(
                            onTap: () {
                              dealsController.loadDeals();
                            },
                          );
                        }

                        final dealsToShow = dealsController.deals;

                        if (dealsToShow.isEmpty) {
                          return Center(
                              child: Text("No deals available".tr));
                        }

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dealsToShow.take(2).map<Widget>((Deal deal) {
                            final style = statusStyles[deal.status.toString()] ??
                                StatusStyle(
                                  backgroundColor: Colors.grey.withAlpha(40),
                                  textColor: Colors.grey,
                                );
                            return GestureDetector(
                              onTap: () {
                                Get.put(DealDetailsController());
                                context.push(AppRoutes.dealDetails.path,
                                    extra: deal);
                              },
                              child: DealCard(
                                companyName: deal.raisonSociale,
                                interlocuteur: deal.interlocuteur,
                                number: deal.numero,
                                trailingWidget: MyChip(
                                  text: deal.status.toString(),
                                  bgColor: style.backgroundColor,
                                  textColor: style.textColor,
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),

                      SizedBox(height: paddingS),

                      // Add Deal Button
                      PrimaryButton(
                        onTap: () {
                          Get.put(DealDetailsController());
                          context.push(AppRoutes.dealDetails.path);
                        },
                        text: "addDeal".tr,
                      ),
                      SizedBox(height: paddingL),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
