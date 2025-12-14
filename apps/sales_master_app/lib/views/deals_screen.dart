import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/deal_status_style.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/deal_details_controller.dart';
import 'package:sales_master_app/controllers/deals_controller.dart';
import 'package:sales_master_app/models/deal.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/deal_card.dart';
import 'package:sales_master_app/widgets/empty_widget.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';
import 'package:sales_master_app/widgets/my_chip.dart';
import 'package:sales_master_app/widgets/page_detail.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});
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
  Widget mydropdownButton(String status, BuildContext context) {
    StatusStyle style = statusStyles[status.toLowerCase()] ??
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
            //title: "mon_portfeuille".tr,
            title: "mon_pipeline".tr,
            bgColor: Theme.of(context).colorScheme.outlineVariant,
            goBack: true,
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
                Text("All deals".tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                // mydropdownButton("depot d'offre", context)
                IntrinsicWidth(
                  child: DropdownButtonHideUnderline(
                    child: Obx(() {
                      final selected = dealsController.selectedDealFilter.value;
                      final style = statusStyles[selected.toLowerCase()] ??
                          StatusStyle(
                            backgroundColor: Colors.grey.withAlpha(40),
                            textColor: Colors.grey,
                          );
                      return DropdownButton2<String>(
                        isExpanded: true,
                        hint: Padding(
                          padding: EdgeInsets.symmetric(horizontal: paddingXs),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: paddingXs),
                            child: Text('type'.tr,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                        selectedItemBuilder: (BuildContext context) {
                          return dealsController.dealsStatusFilters
                              .map((String item) {
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
                        items:
                            // dealsController.dealsStatusFilters
                            // .map((String item) => DropdownMenuItem<String>(
                            //       value: item,
                            //       child: Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: paddingXs),
                            //         child: Text(
                            //           item,
                            //           style:
                            //               Theme.of(context).textTheme.bodySmall,
                            //         ),
                            //       ),
                            //     ))
                            // .toList(),
                            dealsController.dealsStatusFilters
                                .map((String key) {
                          final displayName = key == 'empty' ? '' : key;
                          return DropdownMenuItem<String>(
                            value: key, // keep the key as the value
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingXs),
                              child: Text(
                                displayName,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          );
                        }).toList(),
                        value: dealsController.selectedDealFilter.value,
                        onChanged: (String? key) {
                          if (key != null &&
                              key != dealsController.selectedDealFilter.value) {
                            dealsController.selectedDealFilter.value = key;
                            // send null if 'empty' is selected
                            if (key != "empty") {
                              dealsController.filterDeals(key);
                            } else {
                              dealsController.loadDeals();
                            }
                          }

                          // if (name != null &&
                          //     name !=
                          //         dealsController.selectedDealFilter.value) {
                          //   dealsController.filterDeals(name);
                          // }
                        },
                        buttonStyleData: ButtonStyleData(
                          // decoration: BoxDecoration(
                          //     borderRadius:
                          //         BorderRadius.circular(borderRadiusSmall),
                          //     color:
                          //         Theme.of(context).colorScheme.outlineVariant,
                          //     border: Border.all(
                          //         color: Theme.of(context)
                          //             .colorScheme
                          //             .tertiaryContainer)),
                          decoration: BoxDecoration(
                            color: style.backgroundColor,
                            borderRadius:
                                BorderRadius.circular(borderRadiusSmall),
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
                )
              ],
            ),
          ),
          SizedBox(height:10),
          GestureDetector(
                            onTap: () {
                              // Get.to(AppRoutes.dealsScreen.path);
 Get.put(DealDetailsController());
                          context.push(AppRoutes.dealDetails.path);
                            },
                            child:  formTitle(
                          svgName: "assets/add_deal.svg",
                          title: "addDeal".tr,
                          context: context),
                          ),
 
           SizedBox(
            height: paddingXs,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingL),
            child: CustomTextFormField(
              controller: dealsController.searchController,
              login: false,
              filled: true,
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              hintText: "search_deals".tr,
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
    child: Obx(() {
      if (dealsController.loadingDeals.value && dealsController.deals.isEmpty) {
        return Center(
          child: LoadingIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      }

      if (dealsController.deals.isEmpty) {
        return Center(child: EmptyWidget());
      }

      return RefreshIndicator(
        onRefresh: () => dealsController.loadDeals(reset: true),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!dealsController.isLoadingMore.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              dealsController.loadMoreDeals();
            }
            return false;
          },
          child: ListView.builder(
            itemCount: dealsController.deals.length +
                (dealsController.isLoadingMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              // Show loading indicator at bottom
              if (index == dealsController.deals.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              Deal deal = dealsController.deals[index];

              StatusStyle style = statusStyles[deal.status.toString()] ??
                  StatusStyle(
                      backgroundColor: Colors.grey.withAlpha(80),
                      textColor: Colors.grey);

              return Padding(
                padding: const EdgeInsets.only(bottom: paddingXs),
                child: GestureDetector(
                  onTap: () {
                    Get.put(DealDetailsController());
                    context.push(AppRoutes.dealDetails.path, extra: deal);
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
                ),
              );
            },
          ),
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
