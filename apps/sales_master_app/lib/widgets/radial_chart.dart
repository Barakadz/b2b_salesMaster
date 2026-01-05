import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sales_master_app/config/realisation_category_style.dart';
import 'package:sales_master_app/models/realisation.dart';
class RadialChart extends StatelessWidget {
  final List<Realisation> realisations;
  final double totalrealised;
  final double totalTarget;
  final Color? textColor;
  final bool? gloabl;
  final double? pct_realisation;

  const RadialChart({
    super.key,
    this.textColor,
    this.gloabl = false,
    required this.realisations,
    required this.totalTarget,
    required this.totalrealised,
    this.pct_realisation,
  });

  double get pct {
    if (totalTarget == 0) return 0;
    return (totalrealised / totalTarget * 100).clamp(0, 100);
  }

  List<PieChartSectionData> showSections() {
    // ✅ COPIE LOCALE (IMPORTANT)
    final List<Realisation> data = List.from(realisations);

    // garantir au moins 2 sections
    if (data.length == 1) {
      final double remaining =
          totalrealised >= totalTarget ? 0 : totalTarget - totalrealised;

      data.add(
        Realisation(
          target: totalTarget,
          currentValue: remaining,
          name: "Empty",
        ),
      );
    }

    if (data.isEmpty) {
      data.addAll([
        Realisation(target: 100, currentValue: 100, name: "Empty"),
        Realisation(target: 100, currentValue: 1, name: "Empty"),
      ]);
    }

    return List.generate(data.length, (index) {
      final style = realisationCategoryStyles[data[index].name]!;

      return PieChartSectionData(
        showTitle: false,
        color: style.categoryColor,
        value: data.length <= 2
            ? data[index].currentValue
            : data[index].percentage,
        radius: 20,
      );
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
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              sections: showSections(),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
  "${pct_realisation}%",
  style: Theme.of(context)
      .textTheme
      .titleLarge
      ?.copyWith(color: textColor),
),
                 Text(
                  realisations.length > 2 || gloabl == true
                      ? "Réalisations"
                      : realisations.first.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: textColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String dataLabel() {
    if (gloabl == true || realisations.length > 2) {
      return "Réalisations";
    }
    return realisations.isNotEmpty ? realisations.first.name : "";
  }
}
