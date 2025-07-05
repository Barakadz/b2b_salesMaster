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

  const RealisationOverviewContainer(
      {super.key,
      required this.totalRealisation,
      required this.totalrealised,
      required this.totalTarget,
      required this.loading,
      required this.disabled});

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
            Text(
              "Overview",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: paddingM,
            ),
            RealisationPercentIndicator(
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
                totalrealised: showPlaceHolder ? 0 : totalrealised)
          ],
        ),
      ),
    );
  }
}
