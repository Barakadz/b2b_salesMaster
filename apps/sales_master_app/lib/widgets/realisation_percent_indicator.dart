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
  const RealisationPercentIndicator(
      {super.key,
      this.textColor,
      required this.realisations,
      required this.totalTarget,
      required this.totalrealised});

  Widget buildMultiPercentIndicator() {
    List<Realisation> topBarRealisations = List.from(realisations);
    List<SegmentLinearIndicator> segments = [];

    // just filling the remining space with gray ...
    if (totalrealised != totalTarget) {
      topBarRealisations.add(Realisation(
        target: totalTarget - totalrealised,
        currentValue: totalTarget - totalrealised,
        name: "Empty",
      ));
    }

    for (var realisation in topBarRealisations) {
      final style = realisationCategoryStyles[realisation.name]!;

      double percent = realisation.currentValue / totalTarget;
      percent = percent.clamp(0.0, 1.0);

      print("${realisation.name}: $percent");

      segments.add(SegmentLinearIndicator(
        percent: percent,
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

  Widget buildSinglePercentIndicator(Realisation realisation) {
    final style = realisationCategoryStyles[realisation.name]!;
    final double percent = realisation.currentValue / realisation.target;
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
                  "${r.currentValue.toInt()} / ${r.target.toInt()}",
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
    final double stars = (evaluation.currentValue * 5) / evaluation.target;

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
        SizedBox(
          height: paddingXs,
        ),
        buildAlignedRealisationRows(context, realisationsWithoutEvaluation),
        evaluation != null
            ? buildEvaluationStarsRow(context, evaluation)
            : SizedBox()
      ],
    );
  }
}
