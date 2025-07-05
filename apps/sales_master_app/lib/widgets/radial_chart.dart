import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sales_master_app/config/realisation_category_style.dart';
import 'package:sales_master_app/models/realisation.dart';

class RadialChart extends StatelessWidget {
  final List<Realisation> realisations;
  final double totalrealised;
  final double totalTarget;
  final Color? textColor;
  const RadialChart(
      {super.key,
      this.textColor,
      required this.realisations,
      required this.totalTarget,
      required this.totalrealised});

  List<PieChartSectionData> showSections() {
    if (realisations.length == 1) {
      realisations.add(Realisation(
          target: totalTarget - totalrealised,
          currentValue: totalTarget - totalrealised,
          name: "Empty"));
    } else if (realisations.isEmpty) {
      realisations
          .add(Realisation(target: 100, currentValue: 100, name: "Empty"));
      realisations
          .add(Realisation(target: 100, currentValue: 1, name: "Empty"));
    }
    return List.generate(realisations.length, (index) {
      RealisationCategoryStyle style =
          realisationCategoryStyles[realisations[index].name]!;
      return PieChartSectionData(
          showTitle: false,
          color: style.categoryColor,
          value: realisations[index].currentValue,
          radius: 20);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Stack(
        children: [
          PieChart(
              duration: Duration(milliseconds: 450),
              PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  sections: showSections())),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(totalrealised.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: textColor)),
                Text(
                  "Réalisations",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: textColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
