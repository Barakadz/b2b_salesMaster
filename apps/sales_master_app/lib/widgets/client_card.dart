import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/widgets/my_chip.dart';

class ClientCard extends StatelessWidget {
  final String name;
  final String msisdn;
  final bool isActive;
  const ClientCard(
      {super.key,
      required this.name,
      required this.msisdn,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(borderRadiusMedium)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: paddingM, horizontal: paddingXs),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.work_outlined,
            //   size: 48,
            // ),
            SvgPicture.asset("assets/client.svg"),
            SizedBox(
              width: paddingXs,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(msisdn,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withValues(alpha: 0.5),
                        ))
              ],
            ),
            Spacer(),
            MyChip(
                text: isActive ? "Active" : "Deconnecté",
                bgColor: clientActiveColors[isActive]["bgColor"],
                textColor: clientActiveColors[isActive]["textColor"])
          ],
        ),
      ),
    );
  }
}
