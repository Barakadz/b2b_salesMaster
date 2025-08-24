import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/widgets/loading_indicator.dart';

class PipelineContainer extends StatelessWidget {
  final double? globalValue;
  final bool loading;
  final bool error;
  final Widget errorWidget;
  final bool? raise;
  final Widget child;
  const PipelineContainer(
      {super.key,
      this.globalValue,
      this.raise = true,
      required this.child,
      required this.loading,
      required this.error,
      required this.errorWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          border: Border.all(
              color: Theme.of(context).colorScheme.tertiaryContainer)),
      child: Padding(
        padding: const EdgeInsets.all(paddingM),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: paddingS,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Performance",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                loading == true
                    ? Padding(
                        padding: const EdgeInsets.only(left: paddingXs),
                        child: LoadingIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : SizedBox()
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(paddingS),
                child: Container(
                  child: error == true ? errorWidget : child,
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
    );
  }
}
