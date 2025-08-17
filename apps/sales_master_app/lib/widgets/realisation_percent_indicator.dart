import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/multi_segment_linear_indicator.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/realisation_category_style.dart';
import 'package:sales_master_app/models/realisation.dart';

class RealisationPercentIndicator extends StatelessWidget {
  final List<Realisation> realisations;
  final double totalrealised;
  final double totalTarget;
  final Color? textColor;
  final bool mini;
  final bool showSummary;

  const RealisationPercentIndicator(
      {super.key,
      this.textColor,
      required this.realisations,
      required this.totalTarget,
      required this.totalrealised,
      required this.mini,
      required this.showSummary});

  //Widget buildMultiPercentIndicator() {
  //  List<Realisation> topBarRealisations = List.from(realisations);
  //  List<SegmentLinearIndicator> segments = [];

  //  // just filling the remining space with gray ...
  //  if (totalrealised < totalTarget) {
  //    topBarRealisations.add(Realisation(
  //        target: totalTarget - totalrealised,
  //        currentValue: totalTarget - totalrealised,
  //        name: "Empty",
  //        percentage: 10));
  //  }

  //  for (Realisation realisation in topBarRealisations) {
  //    final style = realisationCategoryStyles[realisation.name]!;

  //    //double percent = realisation.currentValue / totalTarget;
  //    final double percent = (realisation.percentage == 0
  //            ? 0
  //            : realisation.percentage! >= 100
  //                ? 1
  //                : realisation.percentage! / 100) /
  //        5;

  //    print("${realisation.name}: $percent");

  //    segments.add(SegmentLinearIndicator(
  //      percent: percent,
  //      color: style.categoryColor,
  //    ));
  //  }

  //  return MultiSegmentLinearIndicator(
  //    animation: true,
  //    lineHeight: 10,
  //    padding: EdgeInsets.zero,
  //    segments: segments,
  //    width: double.infinity,
  //  );
  //}

  // Widget buildMultiPercentIndicator() {
  //   List<SegmentLinearIndicator> segments = [];

  //   // Convert percentages to [0..1] fractions and clamp >100% to 1
  //   double usedFraction = 0.0;
  //   for (Realisation realisation in realisations) {
  //     if (realisation.name == "Evaluation") continue; // skip evaluation in bar

  //     final style = realisationCategoryStyles[realisation.name]!;
  //     final double percent = (realisation.percentage ?? 0) / 100;
  //     final double clamped = percent.clamp(0.0, 1.0);

  //     if (clamped > 0) {
  //       segments.add(SegmentLinearIndicator(
  //         percent: clamped,
  //         color: style.categoryColor,
  //       ));
  //       usedFraction += clamped;
  //     }
  //   }

  //   // Add gray filler if there’s space left
  //   if (usedFraction < 1.0) {
  //     final emptyStyle = realisationCategoryStyles["Empty"]!;
  //     segments.add(SegmentLinearIndicator(
  //       percent: (1.0 - usedFraction).clamp(0.0, 1.0),
  //       color: emptyStyle.categoryColor,
  //     ));
  //   }

  //   return MultiSegmentLinearIndicator(
  //     animation: true,
  //     lineHeight: 10,
  //     padding: EdgeInsets.zero,
  //     segments: segments,
  //     width: double.infinity,
  //   );
  // }

  Widget buildMultiPercentIndicator() {
    List<Realisation> topBarRealisations = List.from(realisations);
    List<SegmentLinearIndicator> segments = [];

    // Fill the remaining space with gray if needed
    if (totalrealised < totalTarget) {
      topBarRealisations.add(Realisation(
        target: totalTarget - totalrealised,
        currentValue: totalTarget - totalrealised,
        name: "Empty",
        percentage: ((totalTarget - totalrealised) / totalTarget) * 100,
      ));
    }

    //percentages to fractions (0–1)
    List<double> rawPercents = topBarRealisations.map((r) {
      if (r.percentage == null || r.percentage == 0) return 0.0;
      return (r.percentage! > 100 ? 100 : r.percentage!) / 100;
    }).toList();

    // Normalize so the sum = 1.0
    double total = rawPercents.fold(0.0, (a, b) => a + b);
    List<double> normalizedPercents =
        rawPercents.map((p) => total == 0 ? 0.0 : p / total).toList();

    // Build segments
    for (int i = 0; i < topBarRealisations.length; i++) {
      final realisation = topBarRealisations[i];
      final style = realisationCategoryStyles[realisation.name]!;

      segments.add(SegmentLinearIndicator(
        percent: normalizedPercents[i],
        color: style.categoryColor,
      ));
    }

    return MultiSegmentLinearIndicator(
      animation: true,
      lineHeight: 10,
      padding: EdgeInsets.zero,
      segments: segments,
      width: double.infinity,
    );
  }

  // Widget buildMultiPercentIndicator() {
  //   List<Realisation> topBarRealisations = List.from(realisations);
  //   List<SegmentLinearIndicator> segments = [];

  //   // Add empty space if realised < target
  //   if (totalrealised < totalTarget) {
  //     topBarRealisations.add(
  //       Realisation(
  //         target: totalTarget - totalrealised,
  //         currentValue: totalTarget - totalrealised,
  //         name: "Empty",
  //         percentage: ((totalTarget - totalrealised) / totalTarget) * 100,
  //       ),
  //     );
  //   }

  //   // Calculate the sum of percentages (in case they don’t add up to 100)
  //   double totalPercentage = topBarRealisations.fold(
  //     0,
  //     (sum, r) => sum + (r.percentage ?? 0),
  //   );

  //   for (Realisation realisation in topBarRealisations) {
  //     final style = realisationCategoryStyles[realisation.name]!;

  //     // Normalize each percentage so that the sum = 1
  //     final double percent = totalPercentage == 0
  //         ? 0
  //         : ((realisation.percentage ?? 0) / totalPercentage).clamp(0.0, 1.0);

  //     print("${realisation.name}: $percent");

  //     segments.add(SegmentLinearIndicator(
  //       percent: percent,
  //       color: style.categoryColor,
  //     ));
  //   }

  //   return MultiSegmentLinearIndicator(
  //     animation: true,
  //     lineHeight: 10,
  //     padding: EdgeInsets.zero,
  //     segments: segments,
  //     width: double.infinity,
  //   );
  // }

  Widget buildSinglePercentIndicator(Realisation realisation) {
    final style = realisationCategoryStyles[realisation.name]!;
    //final double percent = realisation.currentValue / realisation.target;
    final double percent =
        realisation.percentage == 0 ? 0 : realisation.percentage! / 100;
    final RealisationCategoryStyle emptyStyle =
        realisationCategoryStyles["Empty"]!;

    return MultiSegmentLinearIndicator(
      animation: true,
      lineHeight: 10,
      padding: EdgeInsets.zero,
      width: double.infinity,
      segments: [
        SegmentLinearIndicator(
            percent: percent.clamp(0.0, 1.0), color: style.categoryColor),
        SegmentLinearIndicator(
            percent: (1.0 - percent).clamp(0.0, 1.0),
            color: emptyStyle.categoryColor),
      ],
    );
  }

  Widget buildAlignedRealisationRows(
      BuildContext context, List<Realisation> realisations) {
    const double rowHeight = 25.0;
    final RealisationCategoryStyle emptyStyle =
        realisationCategoryStyles["Empty"]!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column 1: Icon + Label
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: realisations.map((r) {
            final style = realisationCategoryStyles[r.name]!;

            return SizedBox(
              height: rowHeight,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: textColor ?? style.categoryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    r.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        const SizedBox(width: paddingXxs),

        // Column 2: Progress Bar
        Expanded(
          child: Column(
            children: realisations.map((r) {
              final style = realisationCategoryStyles[r.name]!;
              final double percent = r.currentValue / r.target;

              return SizedBox(
                height: rowHeight,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MultiSegmentLinearIndicator(
                    animation: true,
                    lineHeight: 10,
                    padding: EdgeInsets.zero,
                    width: double.infinity,
                    segments: [
                      SegmentLinearIndicator(
                        percent: percent.clamp(0.0, 1.0),
                        color: style.categoryColor,
                      ),
                      SegmentLinearIndicator(
                        percent: (1.0 - percent).clamp(0.0, 1.0),
                        color: emptyStyle.categoryColor,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: realisations.map((r) {
            return SizedBox(
              height: rowHeight,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${r.percentage} / 100",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                      ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildEvaluationStarsRow(BuildContext context, Realisation evaluation) {
    final style = realisationCategoryStyles[evaluation.name]!;
    final double stars = evaluation.currentValue == 0
        ? 0
        : (evaluation.currentValue * 5) / evaluation.target;

    Color starColor = textColor ?? Colors.orange;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          CircleAvatar(
              radius: 5, backgroundColor: textColor ?? style.categoryColor),
          const SizedBox(width: 8),
          Text(
            evaluation.name,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
          ),
          const SizedBox(width: 12),
          Row(
            children: List.generate(5, (index) {
              if (index + 1 <= stars.floor()) {
                return Icon(Icons.star, size: startsIconSize, color: starColor);
              } else if (index < stars && stars - index >= 0.5) {
                return Icon(Icons.star_half,
                    size: startsIconSize, color: starColor);
              } else {
                return Icon(Icons.star_border,
                    size: startsIconSize, color: starColor);
              }
            }),
          ),
          const Spacer(),
          Text(
            "${evaluation.currentValue.toInt()} / ${evaluation.target.toInt()}",
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Realisation> realisationsWithoutEvaluation =
        realisations.where((r) => r.name != "Evaluation").toList();

    final Realisation? evaluation =
        realisations.firstWhereOrNull((r) => r.name == "Evaluation");
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: paddingXxs,
      children: [
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Total Realisation",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Spacer(),
              Text(
                "$totalrealised DA",
                style: Theme.of(context).textTheme.titleSmall,
              )
            ]),
        buildMultiPercentIndicator(),
        mini == false
            ? Padding(
                padding: EdgeInsets.only(top: paddingXs),
                child: buildAlignedRealisationRows(
                    context, realisationsWithoutEvaluation),
              )
            : SizedBox(),
        evaluation != null && mini != true
            ? Padding(
                padding: const EdgeInsets.only(top: paddingXs),
                child: buildEvaluationStarsRow(context, evaluation),
              )
            : SizedBox()
      ],
    );
  }
}
