import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/todolist_status_style.dart';
import 'package:sales_master_app/models/todolist.dart';
import 'package:sales_master_app/widgets/my_chip.dart';

class TodolistCard extends StatelessWidget {
  final Task todolist;
  final void Function() onChecked;
  final void Function() onClicked;
  const TodolistCard(
      {super.key,
      required this.todolist,
      required this.onChecked,
      required this.onClicked});

  Widget checkbox(bool checked, BuildContext context) {
    return checked == true
        ? Container(
            height: 23,
            width: 23,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff0176D6),
                border: Border.all(color: Color(0xff0176D6))),
            child: Center(
              child: Icon(
                Icons.check,
                size: 16,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          )
        : Container(
            height: 23,
            width: 23,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.outlineVariant,
                border:
                    Border.all(color: Theme.of(context).colorScheme.outline)),
            child: SizedBox(),
          );
  }

  @override
  Widget build(BuildContext context) {
    TodolistStatusStyle style = todolistStatusStyle[todolist.priority] ??
        TodolistStatusStyle(
            backgroundColor: Colors.blue.withValues(alpha: 0.3),
            textColor: Colors.blue);
    return GestureDetector(
      onTap: () {
        onClicked();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outlineVariant,
            border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withValues(alpha: 0.05))),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: paddingL, vertical: paddingM),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    onChecked();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: paddingS),
                    child: checkbox(todolist.done, context),
                  )),
              SizedBox(
                width: paddingXs,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      todolist.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      todolist.location ?? "no address",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withValues(alpha: 0.5)),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        size: 16,
                        Icons.calendar_month,
                        color: Color(0xff209852),
                      ),
                      SizedBox(
                        width: paddingXxs,
                      ),
                      Text(
                        todolist.executionDate,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Color(0xff209852),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: paddingXxs,
                      ),
                      Icon(
                        size: 16,
                        Icons.schedule,
                        color: Color(0xff209852),
                      ),
                      Text(
                        todolist.executionTime,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: Color(0xff209852),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  todolist.selfAssigned == false
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              size: 18,
                              Icons.person,
                              color: Color(0xffF6405B),
                            ),
                            SizedBox(
                              width: paddingXxs,
                            ),
                            Text(
                              todolist.assignedBy,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Color(0xffF6405B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      : SizedBox()
                ],
              ),
              Spacer(),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyChip(
                    text: todolist.priority,
                    bgColor: style.backgroundColor,
                    textColor: style.textColor,
                    prefixWidget: SvgPicture.asset(
                      "assets/dotted_circle.svg",
                      color: style.textColor,
                    ),
                  ),
                  SizedBox(
                    height: paddingL,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/inbox.svg",
                        width: 18,
                      ),
                      SizedBox(
                        width: paddingXxs,
                      ),
                      Text(
                        "Inbox",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withValues(alpha: 0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
