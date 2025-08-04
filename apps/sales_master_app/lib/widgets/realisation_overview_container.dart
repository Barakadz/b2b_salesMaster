import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/models/realisation.dart';
import 'package:sales_master_app/widgets/realisation_percent_indicator.dart';

class RealisationOverviewContainer extends StatelessWidget {
  final TotalRealisation totalRealisation;
  final double totalrealised;
  final double totalTarget;
  final bool disabled;
  final bool loading;
  final bool overview;
  final bool mini;
  final bool showSummary;

  const RealisationOverviewContainer(
      {super.key,
      required this.totalRealisation,
      required this.totalrealised,
      required this.totalTarget,
      required this.loading,
      required this.disabled,
      this.overview = true,
      this.mini = false,
      this.showSummary = false});

  Widget summary(BuildContext context) {
    double performance = (totalrealised * 100) / totalTarget;
    return performance > 0
        ? RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Bravo! ',
                  style: Theme.of(context).textTheme.titleSmall),
              TextSpan(
                  text: 'you completed $performance% of your total target',
                  style: Theme.of(context).textTheme.bodySmall),
            ]),
          )
        : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    bool showPlaceHolder = disabled || loading;
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Theme.of(context).colorScheme.tertiaryContainer)),
      child: Padding(
        padding: const EdgeInsets.all(paddingXs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            overview == true
                ? Text(
                    "Overview",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                : SizedBox(),
            RealisationPercentIndicator(
                showSummary: showSummary,
                mini: mini,
                textColor: showPlaceHolder == true
                    ? Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.25)
                    : null,
                realisations: showPlaceHolder
                    ? [
                        Realisation(target: 100, currentValue: 0, name: "GA"),
                        Realisation(
                            target: 100, currentValue: 0, name: "Net Adds"),
                        Realisation(
                            target: 100, currentValue: 0, name: "Solutions"),
                        Realisation(
                            target: 100, currentValue: 0, name: "New Compte"),
                        Realisation(
                            target: 100, currentValue: 0, name: "Evaluation")
                      ]
                    : totalRealisation.realisations,
                totalTarget: showPlaceHolder ? 500 : totalTarget,
                totalrealised: showPlaceHolder ? 0 : totalrealised),
            showSummary == true ? summary(context) : SizedBox()
          ],
        ),
      ),
    );
  }
}
