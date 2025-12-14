import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/controllers/catalogue_controller.dart';

class InternationalTarifView extends StatelessWidget {
  const InternationalTarifView({super.key});

  @override
  Widget build(BuildContext context) {
    final CatalogueController c = Get.find();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 450;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Title + Dropdown ---
            Wrap(
              spacing: 8, // space between items
              runSpacing: 8, // space between lines if wrapped
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Title
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.6, // adjust max width
                  child: Text(
                    "Nos Tarifs International",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Dropdown
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.35, // adjust max width
                  child: IntrinsicWidth(
                    child: DropdownButtonHideUnderline(
                      child: Obx(() => DropdownButton2<String>(
                            isExpanded: true,
                            hint: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'country'.tr,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            items: c.countriesInternational
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.country,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          item.country,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value:
                                c.selectedCountryInternational.value?.country,
                            onChanged: (String? name) {
                              if (name != null) {
                                c.changeCountryInternational(name);
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
                                      .tertiaryContainer,
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
                          )),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Obx(() {
              final techs = c.availableTechnologies;

              if (techs.isEmpty) return const SizedBox();

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      techs.map((tech) => _techTab(context, c, tech)).toList(),
                ),
              );
            }),

            const SizedBox(height: 16),

            // --- Prices ---
            Obx(
              () {
                if (c.loadingInternational.value) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (c.errorInternational.value) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Erreur lors du chargement des tarifs",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (c.selectedCountryInternational.value == null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.public,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Veuillez sélectionner un pays",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final list = c.internationalList
                    .where((e) => e.technology == c.selectedTechnology.value)
                    .toList();

                if (list.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Aucun tarif disponible pour cette technologie",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final t = list.first;

                return Column(
                  children: [
                    _tarifCard(context, "Postpaid", t.postpaid),
                    _tarifCard(context, "Control", t.control),
                    _tarifCard(context, "Prepaid", t.prepaid),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  // --- TAB BUTTON ---
  Widget _techTab(BuildContext context, CatalogueController c, String tech) {
    final selected = c.selectedTechnology.value == tech;

    return GestureDetector(
      onTap: () => c.selectedTechnology.value = tech,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.red.shade50 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          tech.toUpperCase(),
          style: TextStyle(
            color: selected ? Colors.red : Colors.grey.shade500,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _tarifCard(BuildContext context, String label, String price) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey.shade300, width: 1), // Border color and width
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Match container radius
        ),
        child: ListTile(
          leading: const Icon(Icons.phone, color: Colors.red),
          title: Text(
            "Prix $label • En Min TTC",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          trailing: Text(
            price,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
