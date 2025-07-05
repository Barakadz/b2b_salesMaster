import 'package:country_flags/country_flags.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_master_app/config/constants.dart';

class RoamingInfo extends StatelessWidget {
  final String inputCountryCode;
  final String outputCountryCode;
  final bool? reverse;
  final bool? worldWide;
  final String description;
  final int price;
  const RoamingInfo(
      {super.key,
      required this.inputCountryCode,
      required this.outputCountryCode,
      required this.description,
      required this.price,
      this.worldWide,
      this.reverse});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$price DA/Min",
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withValues(alpha: 0.5),
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: paddingS,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CountryFlag.fromCountryCode(
                  inputCountryCode,
                  height: 23,
                  width: 32,
                ),
                Flexible(
                  child: DottedLine(
                    lineThickness: 2,
                    direction: Axis.horizontal,
                    dashColor: Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                ),
                SvgPicture.asset(
                  reverse == true
                      ? "assets/arrow_out.svg"
                      : "assets/arrow_in.svg",
                  height: 22,
                ),
                Flexible(
                  child: DottedLine(
                    lineThickness: 2,
                    direction: Axis.horizontal,
                    dashColor: Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                ),
                worldWide == true
                    ? Icon(
                        Icons.language_sharp,
                        size: 23,
                        color: Color(0xff3BB3F8),
                      )
                    : CountryFlag.fromCountryCode(
                        outputCountryCode,
                        height: 23,
                        width: 32,
                      ),
              ],
            ),
          )
        ]);
  }
}
