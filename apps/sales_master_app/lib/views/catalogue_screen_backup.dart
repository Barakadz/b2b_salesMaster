import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/catalogues_options.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/catalogue_controller.dart';
import 'package:sales_master_app/models/file_model.dart';
import 'package:sales_master_app/widgets/custom_app_drawer.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/empty_widget.dart';
import 'package:sales_master_app/widgets/file_card.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/primary_button.dart';
import 'package:sales_master_app/widgets/process_tab.dart';
import 'package:sales_master_app/widgets/roaming_info.dart';

class CatalogueScreenBackup extends StatelessWidget {
  const CatalogueScreenBackup({super.key});

  Widget offerInfo(
      {required String svgPath,
      required String price,
      required String label,
      required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(svgPath),
        Text(
          price,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.5),
              fontSize: 12,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    CatalogueController catalogueController = Get.put(CatalogueController());
    return Scaffold(
      drawer: CustomAppDrawer(),
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PageDetail(
            baseviewpage: false,
            //title: "mon_portfeuille".tr,
            title: "Catalogues d’offres",
            bgColor: Theme.of(context).colorScheme.outlineVariant,
          ),
          SizedBox(
            height: paddingS,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingL, vertical: paddingXs),
              child: Text(
                "Mon Catalogue",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingL),
            child: CustomTextFormField(
              login: false,
              filled: true,
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              hintText: "Search by file name",
              controller: catalogueController.searchBarTextController,
              prifixIcon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: paddingM, horizontal: paddingL),
            child: Container(
              height: 100,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: catalogueController.catalogue.length,
                  itemBuilder: (context, index) {
                    print(services.length);
                    CatalogueOffer tab = catalogueController.catalogue[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: paddingXs),
                      child: Obx(() {
                        return ProcessTab(
                          onTap: () {
                            catalogueController.switchMainTab(tab.index);
                            print("clicked");
                            print(tab.index);
                          },
                          clickedbgColor: Theme.of(context).colorScheme.primary,
                          clickedBorderColor:
                              Theme.of(context).colorScheme.primary,
                          clickedIconColor:
                              Theme.of(context).colorScheme.onPrimary,
                          tabName: tab.name,
                          //svgPath: tab.svgPath,
                          svgPath: tab.svgPath,
                          clicked:
                              catalogueController.mainTabsIndex == tab.index,
                        );
                      }),
                    );
                  },
                );
              }),
            ),
          ),
          SizedBox(
            height: paddingM,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingL),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Nos Offres",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Obx(() {
                  return catalogueController.mainTabsIndex.value == 0
                      ? IntrinsicWidth(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: paddingXs),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: paddingXs),
                                  child: Text(
                                    'category',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                              items: catalogueController.offers
                                  .map((Offer item) => DropdownMenuItem<String>(
                                        value: item.name,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: paddingXs),
                                          child: Text(
                                            item.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value:
                                  catalogueController.selectedOffer.value?.name,
                              onChanged: (String? name) {
                                if (name != null) {
                                  catalogueController.changeOfferCategory(name);
                                }
                              },
                              buttonStyleData: ButtonStyleData(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outlineVariant,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiaryContainer)),
                                padding:
                                    const EdgeInsets.only(left: 0, right: 8),
                                height: 35,
                                width: double.infinity,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 35,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        )
                      : catalogueController.mainTabsIndex == 2
                          ? IntrinsicWidth(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: paddingXs),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: paddingXs),
                                      child: Text(
                                        'country',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ),
                                  items: catalogueController.countries
                                      .map((Country item) =>
                                          DropdownMenuItem<String>(
                                            value: item.name,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: paddingXs),
                                              child: Text(
                                                item.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: catalogueController
                                      .selectedCountry.value?.name,
                                  onChanged: (String? name) {
                                    if (name != null) {
                                      catalogueController.changeCountry(name);
                                    }
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outlineVariant,
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiaryContainer)),
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 8),
                                    height: 35,
                                    width: double.infinity,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 35,
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox();
                })
              ],
            ),
          ),
          Obx(() {
            return catalogueController.mainTabsIndex.value == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: paddingM, horizontal: paddingL),
                    child: Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: catalogueController
                              .catalogue[0].subServices.length,
                          itemBuilder: (context, index) {
                            print(services.length);
                            OffersCategorie tab = catalogueController
                                .catalogue[0].subServices[index];
                            return Padding(
                                padding:
                                    const EdgeInsets.only(right: paddingXs),
                                child: Obx(() {
                                  return ProcessTab(
                                    png: true,
                                    subcategory: true,

                                    onTap: () {
                                      catalogueController
                                          .switchSubTab(tab.index);

                                      print("clicked");
                                      print(tab.index);
                                    },
                                    // clickedbgColor: Theme.of(context)
                                    //     .colorScheme
                                    //     .primary
                                    //     .withValues(alpha: 0.04),
                                    // clickedBorderColor:
                                    //     Theme.of(context).colorScheme.primary,
                                    // clickedIconColor:
                                    //     Theme.of(context).colorScheme.onPrimary,
                                    tabName: tab.name,
                                    svgPath: tab.svgPath,
                                    clicked:
                                        catalogueController.offersSubTabIndex ==
                                            tab.index,
                                  );
                                }));
                          },
                        )),
                  )
                : SizedBox();
          }),
          Expanded(
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: paddingS, horizontal: paddingL),
                child: catalogueController.loadingFiles.value == true
                    ? Center(child: LoadingIndicator())
                    : catalogueController.files.length == 0
                        ? EmptyWidget()
                        : catalogueController.mainTabsIndex.value == 2 &&
                                catalogueController.selectedCountry.value !=
                                    null
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: paddingM,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: paddingXxs),
                                      child:
                                          SvgPicture.asset("assets/call.svg"),
                                    ),
                                    RoamingInfo(
                                        inputCountryCode: catalogueController
                                            .selectedCountry.value!.code,
                                        outputCountryCode: "dz",
                                        description: "Appel vers l'Algérie",
                                        price: 165),
                                    RoamingInfo(
                                        inputCountryCode: catalogueController
                                            .selectedCountry.value!.code,
                                        outputCountryCode: catalogueController
                                            .selectedCountry.value!.code,
                                        worldWide: false,
                                        description: "Appel en local",
                                        price: 115),
                                    RoamingInfo(
                                        inputCountryCode: catalogueController
                                            .selectedCountry.value!.code,
                                        outputCountryCode: catalogueController
                                            .selectedCountry.value!.code,
                                        description:
                                            "Appel vers le reste du monde",
                                        worldWide: true,
                                        price: 165),
                                    RoamingInfo(
                                        inputCountryCode: catalogueController
                                            .selectedCountry.value!.code,
                                        outputCountryCode: catalogueController
                                            .selectedCountry.value!.code,
                                        reverse: true,
                                        worldWide: true,
                                        description: "Appel recu",
                                        price: 45),
                                    SizedBox(
                                      height: paddingS,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        offerInfo(
                                            svgPath: "assets/sms.svg",
                                            price: "45 DA",
                                            label: "SMS émis",
                                            context: context),
                                        offerInfo(
                                            svgPath: "assets/wifi.svg",
                                            price: "1690 DA/Mo",
                                            label: "internet",
                                            context: context)
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: catalogueController.files.length,
                                itemBuilder: (context, index) {
                                  CatalogueFile file =
                                      catalogueController.files[index];
                                  return GestureDetector(
                                    onTap: () {
                                      if (catalogueController
                                              .clickedFileIndex.value !=
                                          index) {
                                        catalogueController
                                            .clickedFileIndex.value = index;
                                      } else {
                                        catalogueController
                                            .clickedFileIndex.value = 10000;
                                      }
                                    },
                                    child: Obx(() {
                                      return FileCard(
                                        file: file,
                                        clicked: catalogueController
                                                .clickedFileIndex.value ==
                                            index,
                                        png: true,
                                      );
                                    }),
                                  );
                                }),
              );
            }),
          ),
          Obx(() {
            return catalogueController.clickedFileIndex != 10000
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: paddingL),
                    child: PrimaryButton(onTap: () {}, text: "Download"),
                  )
                : SizedBox();
          })
        ],
      )),
    );
  }
}
