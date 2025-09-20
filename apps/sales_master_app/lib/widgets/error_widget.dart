import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomErrorWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: paddingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/error_icon.svg",
            height: 30,
            width: 30,
          ),
          SizedBox(
            height: paddingS,
          ),
          Text(
            "Ouups. Error Detected!".tr,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
          ),
          SizedBox(
            height: paddingXxs,
          ),
          Text(
            "Please check your internet connection and try again".tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withValues(alpha: 0.25)),
          ),
          SizedBox(
            height: paddingM,
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: paddingS,
              children: [
                SvgPicture.asset(
                  "assets/refresh.svg",
                  width: 16,
                  height: 16,
                ),
                Text(
                  "Refresh".tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
