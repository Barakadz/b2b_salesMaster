import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/models/pipeline_performance.dart';

class PipelineChart extends StatelessWidget {
  final PipelinePerformance pipeline;

  const PipelineChart({super.key, required this.pipeline});

  Widget fullBarWithHInt(
      {required BuildContext context,
      required double value,
      required String name,
      required Color progressColor}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // LinearPercentIndicator(
        //   width: 40,
        //   lineHeight: 161,
        //   percent: 0.5,
        //   backgroundColor: Color(0xffE9ECF1).withValues(alpha: 0.5),
        //   progressColor: progressColor,
        // ),
        RotatedBox(
          quarterTurns: -1,
          child: LinearPercentIndicator(
            animation: true,
            width: 161,
            lineHeight: 35,
            percent: value / 100,
            backgroundColor: Color(0xffE9ECF1)
                .withAlpha(128), // withAlpha instead of withValues
            progressColor: progressColor,
            barRadius: Radius.circular(3), // optional: for rounded corners
          ),
        ),
        SizedBox(
          height: paddingS,
        ),
        Text(
          value.toString().split(".")[0],
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 70),
          child: Text(
            name.replaceAll(" ", "\n"),
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            maxLines: 4,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  // color: Theme.of(context)
                  //     .colorScheme
                  //     .onSurfaceVariant
                  //     .withValues(alpha: 0.5),
                ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: paddingXs,
      children: [
        fullBarWithHInt(
            context: context,
            value: pipeline.priseContact,
            name: "Prise Contact",
            progressColor: Color(0xffDCDEE3)),
        fullBarWithHInt(
            context: context,
            value: pipeline.depotDoffre,
            name: "Depot d'offre",
            progressColor: Color(0xff6AC8FF)),
        fullBarWithHInt(
            context: context,
            value: pipeline.enCours,
            name: "En cours",
            progressColor: Color(0xffFFD65C)),
        fullBarWithHInt(
            context: context,
            value: pipeline.conclusion,
            name: "Conclusion",
            progressColor: Color(0xff53DAA0)),
        fullBarWithHInt(
            context: context,
            value: pipeline.conclusion,
            name: "On Hold",
            progressColor: Color(0xffF6405B)),
      ],
    );
  }
}
