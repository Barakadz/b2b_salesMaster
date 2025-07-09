import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/deal_status_style.dart';
import 'package:sales_master_app/models/pipeline_performance.dart';

class PipelineChart extends StatelessWidget {
  final List<PipelineStat> stats;

  const PipelineChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: paddingXs,
      children: stats.map((stat) {
        final style = statusStyles[stat.status.toLowerCase()] ??
            StatusStyle(
                backgroundColor: Colors.grey.withAlpha(50),
                textColor: Colors.grey);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotatedBox(
              quarterTurns: -1,
              child: LinearPercentIndicator(
                animation: true,
                width: 161,
                lineHeight: 35,
                percent: stat.percentage / 100,
                backgroundColor: Color(0xffE9ECF1).withAlpha(128),
                progressColor: style.textColor,
                barRadius: Radius.circular(3),
              ),
            ),
            SizedBox(height: paddingS),
            Text(
              stat.count.toString().padLeft(2, '0'),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 70),
              child: Text(
                stat.status.replaceAll(" ", "\n"),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            )
          ],
        );
      }).toList(),
    );
  }
}
