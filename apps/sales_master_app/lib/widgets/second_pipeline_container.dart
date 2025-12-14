import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/deal_status_style.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/models/pipeline_performance.dart';
import 'package:sales_master_app/widgets/pipeline_icon_circle.dart';
import 'package:sales_master_app/widgets/pipeline_radial_chart.dart';

class SecondPipelineContainer extends StatelessWidget {
  final double? globalValue;
  final bool loading;
  final bool error;
  final Widget errorWidget;
  final bool? raise;
  final int selectedStatusIndex;
  final PipelinePerformance pipelinePerformance;
  final void Function(int index) onStatusSelected;

  const SecondPipelineContainer(
      {super.key,
      this.globalValue,
      this.raise = true,
      required this.selectedStatusIndex,
      required this.loading,
      required this.error,
      required this.errorWidget,
      required this.pipelinePerformance,
      required this.onStatusSelected});

  Widget mainWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: paddingS,
      children: [
        //chart

        PipelineRadialChart(
            pipelienState: pipelinePerformance.stats[selectedStatusIndex]),
         //controll row
        Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: List.generate(pipelinePerformance.stats.length, (index) {
    String assetPath = statusStyles[
                pipelinePerformance.stats[index].status.toLowerCase()]
            ?.svgPath ??
        "assets/pending.svg";

    return Expanded(
      child: GestureDetector(
        onTap: () => onStatusSelected(index),
        child: PipelineIconCircle(
          clicked: selectedStatusIndex == index,
          svgPath: assetPath,
          title: pipelinePerformance.stats[index].status,
        ),
      ),
    );
  }),
)

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          border: Border.all(
              color: Theme.of(context).colorScheme.tertiaryContainer)),
      child: Padding(
        padding: const EdgeInsets.all(paddingM),
        child: InkWell(
  onTap: () {
    // Go to another page with GoRouter
                  context.push(AppRoutes.pipeline.path);
  },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: paddingS,
            children: [
                  Padding(
                  padding: const EdgeInsets.all(paddingS),
                  child: Container(
                    child: error == true ? errorWidget : mainWidget(),
                  )),
              globalValue != null
                  ? Container(
                      constraints: BoxConstraints(
                        maxWidth: 350,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            "${globalValue.toString()}%",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: paddingXs,
                          ),
                          Text(
                            "Your Performance is $globalValue%\n${raise == true ? "better" : "worst"} compared to last month",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant
                                          .withValues(alpha: 0.5),
                                    ),
                          )
                        ],
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
