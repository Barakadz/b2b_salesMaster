import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sales_master_app/config/deal_status_style.dart';
import 'package:sales_master_app/models/pipeline_performance.dart';

class PipelineRadialChart extends StatelessWidget {
  final PipelineStat pipelienState;
  final Color? textColor;
  const PipelineRadialChart({
    super.key,
    this.textColor,
    required this.pipelienState,
  });

  List<PieChartSectionData> showSections() {
    List<PipelineStat> stats = [pipelienState];
    stats.add(PipelineStat(
        status: "empty", count: 0, percentage: 100 - pipelienState.percentage));
    return List.generate(stats.length, (index) {
      StatusStyle style = statusStyles[stats[index].status.toLowerCase()]!;
      return PieChartSectionData(
          showTitle: false,
          color: style.textColor,
          value: stats[index].percentage,
          radius: 20);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
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
                Text(pipelienState.count.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: textColor)),
                Text(
                  pipelienState.status,
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
