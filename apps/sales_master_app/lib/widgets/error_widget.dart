import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/widgets/primary_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomErrorWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 40, color: Theme.of(context).iconTheme.color),
        SizedBox(
          height: paddingS,
        ),
        Text(
          "Error".tr,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.5)),
        ),
        SizedBox(
          height: paddingXxs,
        ),
        Text(
          "could not load data".tr,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 13,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.5)),
        ),
        SizedBox(
          height: paddingS,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "reload".tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        )
      ],
    );
  }
}
