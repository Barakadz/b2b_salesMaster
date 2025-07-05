import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/models/file_model.dart';
import 'package:sales_master_app/widgets/inbox_widget.dart';

class ProcessCard extends StatelessWidget {
  final UploadedFile file;
  const ProcessCard({super.key, required this.file});

  Widget checkbox(BuildContext context) {
    return Container(
      height: 14,
      width: 14,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xCC3DDD95),
          border: Border.all(color: Color(0xCC3DDD95))),
      child: Center(
        child: Icon(
          Icons.check,
          size: 12,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          color: Theme.of(context).colorScheme.outlineVariant),
      child: Padding(
        padding: const EdgeInsets.all(paddingS),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/file.svg"),
            SizedBox(
              width: paddingS,
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          file.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      Text(
                        file.uploadDate,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withValues(alpha: 0.5)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${file.size} ${file.unity} -",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withValues(alpha: 0.5)),
                      ),
                      SizedBox(
                        width: paddingXxs,
                      ),
                      checkbox(context),
                      SizedBox(
                        width: paddingXxs,
                      ),
                      Text(
                        "Completed",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withValues(alpha: 0.5)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.person, size: 18),
                            SizedBox(
                              width: paddingXxs,
                            ),
                            Flexible(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                file.uploadedBy,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant
                                            .withValues(alpha: 0.5)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InboxWidget()
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
