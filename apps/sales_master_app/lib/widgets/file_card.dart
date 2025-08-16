import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/models/file_model.dart';
import 'package:sales_master_app/widgets/inbox_widget.dart';

class FileCard extends StatelessWidget {
  final CatalogueFile file;
  final bool? png;
  final bool clicked;
  const FileCard(
      {super.key, required this.file, required this.clicked, this.png});

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
        color: clicked == true
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.02)
            : Theme.of(context).colorScheme.outlineVariant,
        border: Border.all(
            color: clicked == true
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
                : Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(paddingXs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            png == true
                ? Container(
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Image.asset(
                      "assets/file_preview.png",
                      fit: BoxFit.cover,
                    ))
                : SvgPicture.asset(
                    "assets/file_preview.svg",
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
            SizedBox(
              height: paddingS,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    file.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Text(
                  file.uploadDate.substring(0, 10),
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
            SizedBox(
              height: paddingS,
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
    );
  }
}
