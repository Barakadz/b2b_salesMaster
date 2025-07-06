import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/models/realisation.dart';
import 'package:sales_master_app/widgets/radial_chart.dart';
import 'package:sales_master_app/widgets/salary_note.dart';

class RealisationChartContainer extends StatelessWidget {
  final String date;
  final bool gloabl;
  final double increase;
  final TotalRealisation totalRealisations;
  final double totalrealised;
  final double totalTarget;
  final bool disabled;
  const RealisationChartContainer(
      {super.key,
      required this.date,
      required this.gloabl,
      required this.totalrealised,
      required this.totalTarget,
      this.increase = 0,
      this.disabled = false,
      required this.totalRealisations});

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.chevron_left,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.5)),
                Text(
                  date,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Icon(Icons.chevron_right,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.5))
              ],
            ),
            SizedBox(
              height: paddingXs,
            ),
            Container(
                height: 200,
                child: RadialChart(
                  gloabl: gloabl,
                  textColor: disabled == true
                      ? Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withValues(alpha: 0.25)
                      : null,
                  realisations: totalRealisations.realisations,
                  totalTarget: totalTarget,
                  totalrealised: totalrealised,
                )),
            SizedBox(
              height: paddingXs,
            ),
            disabled == true
                ? SalaryNote(
                    raise: totalRealisations.increase,
                    borderColor:
                        Theme.of(context).dividerColor.withValues(alpha: 0.5),
                    bgColor:
                        Theme.of(context).dividerColor.withValues(alpha: 0.07),
                    textColor: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.25),
                    prefixSvgPath: "assets/congrat_left.svg",
                    suffixSvgPath: "assets/congrat_right.svg",
                  )
                : totalRealisations.increase > 0
                    ? SalaryNote(
                        raise: totalRealisations.increase,
                        borderColor: disabled == true
                            ? Theme.of(context)
                                .dividerColor
                                .withValues(alpha: 0.5)
                            : null,
                        bgColor: disabled == true
                            ? Theme.of(context)
                                .dividerColor
                                .withValues(alpha: 0.07)
                            : null,
                        textColor: disabled == true
                            ? Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withValues(alpha: 0.25)
                            : null,
                        prefixSvgPath: "assets/congrat_left.svg",
                        suffixSvgPath: "assets/congrat_right.svg",
                      )
                    : SizedBox()
          ],
        ),
      ),
    );
  }
}
