import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/deal_status_style.dart';

class PipelineIconCircle extends StatelessWidget {
  final bool clicked;
  final String svgPath;
  final String title;

  const PipelineIconCircle(
      {super.key,
      required this.clicked,
      required this.svgPath,
      required this.title});

  @override
  Widget build(BuildContext context) {
    StatusStyle style = statusStyles[title.toLowerCase()] ??
        StatusStyle(
            backgroundColor: Colors.grey.shade50, textColor: Colors.grey);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: paddingS,
      children: [
        clicked == true
            ? Container(
                decoration: BoxDecoration(
                  color: style.backgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: style.backgroundColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(paddingS),
                  child: Center(
                      child: SvgPicture.asset(
                    height: 16,
                    svgPath,
                    color: style.textColor,
                  )),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color:
                            Theme.of(context).colorScheme.tertiaryContainer)),
                child: Padding(
                  padding: const EdgeInsets.all(paddingS),
                  child: Center(
                      child: SvgPicture.asset(
                    height: 16,
                    svgPath,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.4),
                  )),
                ),
              ),
        Container(
          constraints: BoxConstraints(maxWidth: 70),
          child: Text(
            title.replaceAll(" ", "\n"),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withValues(alpha: 0.5),
                fontWeight: FontWeight.w500,
                fontSize: 10),
          ),
        )
      ],
    );
  }
}
