import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/catalogue_controller.dart';
import 'package:sales_master_app/models/coutry_model.dart';
import 'package:sales_master_app/widgets/custom_tab.dart';
import 'package:sales_master_app/widgets/empty_widget.dart';
import 'package:sales_master_app/widgets/file_card.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';
import 'package:sales_master_app/widgets/roaming_info.dart';

class RoamingView extends StatelessWidget {
  const RoamingView({super.key});

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
    CatalogueController catalogueController = Get.find();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: paddingS,
      children: [
        Row(
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
            IntrinsicWidth(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingXs),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: paddingXs),
                      child: Text(
                        'country',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  items: catalogueController.countries
                      .map((Country item) => DropdownMenuItem<String>(
                            value: item.country,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingXs),
                              child: Text(
                                item.country,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ))
                      .toList(),
                  value: catalogueController.selectedCountry.value?.country,
                  onChanged: (String? name) {
                    if (name != null) {
                      catalogueController.changeCountry(name);
                    }
                  },
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiaryContainer)),
                    padding: const EdgeInsets.only(left: 0, right: 8),
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
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: paddingS,
          children: [
            Obx(() {
              return CustomTab(
                  isActive: catalogueController.roamingType.value == "prepaid",
                  title: "prepaid",
                  ontap: () {
                    catalogueController.switchRoamingType("prepaid");
                  });
            }),
            Obx(() {
              return CustomTab(
                  isActive: catalogueController.roamingType.value == "control",
                  title: "control",
                  ontap: () {
                    catalogueController.switchRoamingType("control");
                  });
            }),
          ],
        ),
        Obx(() {
          return catalogueController.loadingRoaming.value == true
              ? Center(child: LoadingIndicator())
              : catalogueController.roaming.value == null ||
                      catalogueController.selectedCountry.value == null
                  ? Center(child: EmptyWidget())
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: paddingM,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: paddingXxs),
                            child: SvgPicture.asset("assets/call.svg"),
                          ),
                          RoamingInfo(
                              inputCountryCode: catalogueController
                                  .selectedCountry.value!.countryCode,
                              outputCountryCode: "dz",
                              description: "Appel vers l'Algérie",
                              price: catalogueController
                                  .roaming.value!.callToAlgeria),
                          RoamingInfo(
                              inputCountryCode: catalogueController
                                  .selectedCountry.value!.countryCode,
                              outputCountryCode: catalogueController
                                  .selectedCountry.value!.countryCode,
                              worldWide: false,
                              description: "Appel en local",
                              price:
                                  catalogueController.roaming.value!.localCall),
                          RoamingInfo(
                              inputCountryCode: catalogueController
                                  .selectedCountry.value!.countryCode,
                              outputCountryCode: catalogueController
                                  .selectedCountry.value!.countryCode,
                              description: "Appel vers le reste du monde",
                              worldWide: true,
                              price: catalogueController
                                  .roaming.value!.internationalCall),
                          RoamingInfo(
                              inputCountryCode: catalogueController
                                  .selectedCountry.value!.countryCode,
                              outputCountryCode: catalogueController
                                  .selectedCountry.value!.countryCode,
                              reverse: true,
                              worldWide: true,
                              description: "Appel recu",
                              price: catalogueController
                                  .roaming.value!.receiveCall),
                          SizedBox(
                            height: paddingS,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              offerInfo(
                                  svgPath: "assets/sms.svg",
                                  price:
                                      "${catalogueController.roaming.value!.sms} DA",
                                  label: "SMS émis",
                                  context: context),
                              offerInfo(
                                  svgPath: "assets/wifi.svg",
                                  price:
                                      "${catalogueController.roaming.value!.dataB2B} DA/Mo",
                                  label: "internet",
                                  context: context)
                            ],
                          )
                        ],
                      ),
                    );
        }),
      ],
    );
  }
}
