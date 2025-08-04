import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/controllers/deal_details_controller.dart';
import 'package:sales_master_app/models/deal.dart';
import 'package:sales_master_app/models/deal_status.dart';
import 'package:sales_master_app/services/date_input_formatter.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/dropdown_container.dart';
import 'package:sales_master_app/widgets/note.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sales_master_app/widgets/primary_button.dart';

class DealsDetailsScreen extends StatelessWidget {
  final Deal? deal;
  const DealsDetailsScreen({super.key, this.deal});

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

  @override
  build(BuildContext context) {
    DealDetailsController dealDetailsController =
        Get.find<DealDetailsController>();
    dealDetailsController.initializeForm(newDeal: deal);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Column(
        children: [
          PageDetail(title: "Mon Pipeline"),
          SizedBox(height: paddingS),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(paddingL),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  deal == null
                      ? formTitle(
                          svgName: "assets/add_deal.svg",
                          title: "Add New Deal",
                          context: context)
                      : formTitle(
                          svgName: "assets/edit_deal.svg",
                          title: "Modifier Deal",
                          context: context),
                  SizedBox(
                    height: paddingS,
                  ),
                  Text("INFORMATIONS GÉNÉRALES"),
                  SizedBox(
                    height: paddingXs,
                  ),
                  CustomTextFormField(
                    customTextField: true,
                    controller: dealDetailsController.raisonSociale,
                    validator: (String? name) {
                      return dealDetailsController.validateNames(name);
                    },
                    innerPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    suffixIcon: Icon(
                      Icons.border_color,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    prifixIcon: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.outline))),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: paddingS),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.mail_sharp,
                            //   color: Theme.of(context).dividerColor,
                            //   size: 20,
                            // ),
                            // SizedBox(
                            //   width: paddingXs,
                            // ),
                            Text(
                              "Raison Sociale*",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant
                                          .withValues(alpha: 0.15),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: paddingS,
                  ),
                  CustomTextFormField(
                    customTextField: true,
                    controller: dealDetailsController.interlocuteur,
                    validator: (String? name) {
                      return dealDetailsController.validateNames(name);
                    },
                    innerPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    suffixIcon: Icon(
                      Icons.border_color,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    prifixIcon: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.outline))),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: paddingS),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Theme.of(context).dividerColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: paddingXxs,
                            ),
                            Text(
                              "Interlocuteur",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant
                                          .withValues(alpha: 0.15),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: paddingS,
                  ),
                  CustomTextFormField(
                    customTextField: true,
                    controller: dealDetailsController.numero,
                    validator: (String? number) {
                      return dealDetailsController.validateNumber(number);
                    },
                    innerPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    suffixIcon: Icon(
                      Icons.border_color,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    prifixIcon: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.outline))),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: paddingS),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              color: Theme.of(context).dividerColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: paddingXxs,
                            ),
                            Text(
                              "Numero*",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant
                                          .withValues(alpha: 0.15),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: paddingS,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                                      .withValues(alpha: 0.2),
                                ),
                                SizedBox(
                                  width: paddingXxs,
                                ),
                                Text(
                                  "Date de visite",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant
                                              .withValues(alpha: 0.5)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: paddingXxs,
                            ),
                            CustomTextFormField(
                              radius: 7,
                              filled: false,
                              login: false,
                              hintText: "dd-mm-yyyy",
                              validator: (String? date) {
                                return dealDetailsController
                                    .validateNumber(date, date: true);
                              },
                              keyboardType: TextInputType.number,
                              textFormaters: [
                                LengthLimitingTextInputFormatter(10),
                                DateInputFormatter(),
                              ],
                              controller: dealDetailsController.visitDate,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: paddingXs,
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                                      .withValues(alpha: 0.2),
                                ),
                                SizedBox(
                                  width: paddingXxs,
                                ),
                                Text(
                                  "Date prochaine visite",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant
                                              .withValues(alpha: 0.5)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: paddingXxs,
                            ),
                            CustomTextFormField(
                              hintText: 'dd-mm-yyyy',
                              keyboardType: TextInputType.number,
                              validator: (String? date) {
                                return dealDetailsController
                                    .validateNumber(date, date: true);
                              },
                              radius: 7,
                              filled: false,
                              login: false,
                              controller: dealDetailsController.nextVisittDate,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: paddingS,
                  ),
                  Container(
                    width: double.infinity,
                    child: DropdownContainer(
                      label: "Status*",
                      dropdown: Obx(() {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'status',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            items: dealDetailsController.dealsStatus
                                .map((DealStatus item) =>
                                    DropdownMenuItem<String>(
                                      value: item.name,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: paddingXs),
                                        child: Container(
                                          width: double.infinity,
                                          child: Text(
                                            item.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: dealDetailsController.selectedDeal.value,
                            onChanged: (String? name) {
                              if (name != null) {
                                dealDetailsController.selectedDeal.value = name;
                              }
                            },
                            buttonStyleData: ButtonStyleData(
                              elevation: 0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              //padding: const EdgeInsets.only(left: 0, right: 8),
                              height: 40,
                              width: double.infinity,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        );
                      }),
                      prefixIcon: SvgPicture.asset("assets/dotted_circle.svg"),
                    ),
                  ),
                  SizedBox(
                    height: paddingS,
                  ),
                  CustomTextFormField(
                    radius: 7,
                    controller: dealDetailsController.mom,
                    hintText: AppLocalizations.of(context)!.mom,
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: paddingXl,
                  ),
                  Note(
                      info:
                          "En cliquant sur Enregistrer, un e-mail MOM sera envoyé a vous meme et l'affaire sera ajoutée à votre pipeline"),
                  SizedBox(
                    height: paddingS,
                  ),
                  Obx(() {
                    return PrimaryButton(
                        loading: dealDetailsController.saving.value,
                        onTap: () async {
                          bool res = deal == null
                              ? await dealDetailsController.createNewDeal()
                              : await dealDetailsController.editDeal(deal!.id);
                        },
                        text: "Enregistrer");
                  })
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}
