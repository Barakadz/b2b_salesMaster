import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/config/todolist_status_style.dart';
import 'package:sales_master_app/controllers/todolist_controller.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';
import 'package:sales_master_app/widgets/my_chip.dart';
import 'package:sales_master_app/widgets/page_detail.dart';
import 'package:sales_master_app/widgets/primary_button.dart';
import 'package:sales_master_app/widgets/time_picker.dart';
import 'package:sales_master_app/widgets/todolist_card.dart';
import 'package:date_picker_plus/date_picker_plus.dart';

class TodolistScreen extends StatelessWidget {
  const TodolistScreen({super.key});
  Widget myDatePicker(
      TextEditingController dateController, BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 290),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline)),
      child: DatePicker(
        minDate: DateTime.now().subtract(const Duration(days: 365)),
        maxDate: DateTime.now().add(const Duration(days: 365)),
        initialDate: DateTime.now(),
        currentDateTextStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
        selectedDate: DateTime.tryParse(dateController.text),
        daysOfTheWeekTextStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        enabledCellsTextStyle: Theme.of(context).textTheme.bodySmall,
        disabledCellsTextStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        selectedCellTextStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.surface),
        onDateSelected: (value) {
          dateController.text = value.toString().substring(0, 10);
        },
      ),
    );
  }

  Widget chipBuilder(String name, int index, BuildContext context,
      TodolistController controller) {
    TodolistStatusStyle style = controller.newTaskSatatusIndex.value == index
        ? todolistStatusStyle[name] ??
            TodolistStatusStyle(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.3),
                textColor: Theme.of(context).colorScheme.primary)
        : TodolistStatusStyle(
            backgroundColor: Color(0x40D2D2D2), textColor: Color(0xffD2D2D2));

    return GestureDetector(
      onTap: () {
        controller.switchNewTaskIndex(index);
      },
      child: MyChip(
          text: name,
          bgColor: style.backgroundColor,
          showBorders: true,
          horizontalPadding: paddingM,
          borderRadius: 25,
          textColor: style.textColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    TodolistController todolistController = Get.put(TodolistController());
    //todolistController.loadFakeTodolist();
    todolistController.loadTasks();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: paddingS,
          ),
          PageDetail(
            title: "To do list",
          ),
          SizedBox(height: paddingXs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingL),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "My To do list ",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showPopover(
                      barrierColor: Colors.transparent,
                      context: context,
                      bodyBuilder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Mine'),
                            onTap: () {
                              Navigator.pop(context);
                              // handle edit
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Assigned to me'),
                            onTap: () {
                              Navigator.pop(context);
                              // handle delete
                            },
                          ),
                        ],
                      ),
                      width: 100,
                      //direction: PopoverDirection.bottom,
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer
                                  .withValues(alpha: 0.8))),
                      child: Padding(
                        padding: const EdgeInsets.all(paddingXxs),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                todolistController.typeFilter.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: paddingXxs,
                              ),
                              Icon(
                                Icons.arrow_downward,
                                size: 20,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              )
                            ]),
                      )),
                ),
                SizedBox(
                  width: paddingXs,
                ),
                GestureDetector(
                  onTap: () {
                    context.go(AppRoutes.todolistArchive.path);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiaryContainer
                                .withValues(alpha: 0.8))),
                    child: Padding(
                      padding: const EdgeInsets.all(paddingXxs),
                      child: SvgPicture.asset(
                        "assets/archive.svg",
                        width: 20,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: paddingS,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingL),
            child: CustomTextFormField(
              hintText: 'Search by task name',
              controller: todolistController.todolistSearchController,
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              filled: true,
              login: false,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingM),
            child: Obx(() {
              return ListView.builder(
                  itemCount: todolistController.todolist.length,
                  itemBuilder: (context, index) {
                    return TodolistCard(
                        onChecked: () {
                          todolistController.togglecheck(index);
                        },
                        todolist: todolistController.todolist[index]);
                  });
            }),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: paddingL, vertical: paddingS),
            child: PrimaryButton(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.sizeOf(context).height * 0.7),
                    useSafeArea: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(0)),
                    ),
                    context: context,
                    //enableDrag: true,
                    //showDragHandle: true,
                    elevation: 1,
                    backgroundColor:
                        Theme.of(context).colorScheme.outlineVariant,
                    builder: (BuildContext context) {
                      return Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(paddingL),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // SvgPicture.asset(
                                    //   "assets/tasks.svg",
                                    // ),
                                    Icon(
                                      Icons.pending_actions_sharp,
                                      size: 24,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    SizedBox(
                                      width: paddingS,
                                    ),
                                    Text("Ajouter une tache",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge)
                                  ],
                                ),
                                SizedBox(
                                  height: paddingS,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Obx(() {
                                      return chipBuilder("Low", 0, context,
                                          todolistController);
                                    }),
                                    Obx(() {
                                      return chipBuilder("Medium", 1, context,
                                          todolistController);
                                    }),
                                    Obx(() {
                                      return chipBuilder("High", 2, context,
                                          todolistController);
                                    })
                                  ],
                                ),
                                SizedBox(
                                  height: paddingS,
                                ),
                                Text(
                                  "DATE",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant
                                              .withValues(alpha: 0.5)),
                                ),
                                SizedBox(height: paddingXs),
                                //date
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: CustomTextFormField(
                                        onTap: () {
                                          todolistController
                                              .showTasTimePicker.value = false;
                                          todolistController.showTaskDatePicker
                                              .toggle();
                                        },
                                        filled: false,
                                        readOnly: true,
                                        controller: todolistController
                                            .taskDateController,
                                        login: false,
                                        prifixIcon: Icon(
                                          size: 18,
                                          Icons.calendar_today,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: paddingS,
                                    ),
                                    Flexible(
                                      child: CustomTextFormField(
                                        filled: false,
                                        readOnly: true,
                                        onTap: () {
                                          todolistController
                                              .showTaskDatePicker.value = false;
                                          todolistController.showTasTimePicker
                                              .toggle();
                                        },
                                        controller: todolistController
                                            .tasktimeController,
                                        login: false,
                                        prifixIcon: Icon(
                                          size: 18,
                                          Icons.schedule,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(() {
                                  return todolistController
                                              .showTaskDatePicker.value ==
                                          true
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: paddingXs),
                                          child: Center(
                                            child: Container(
                                              width: double.infinity,
                                              child: myDatePicker(
                                                  todolistController
                                                      .taskDateController,
                                                  context),
                                            ),
                                          ),
                                        )
                                      : todolistController
                                                  .showTasTimePicker.value ==
                                              true
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: paddingXs),
                                              child: WheelTimePicker(
                                                initialTime: TimeOfDay.now(),
                                                onChanged: (newtime) {
                                                  todolistController
                                                          .tasktimeController
                                                          .text =
                                                      "${newtime.hour.toString().padLeft(2, '0')}:${newtime.minute.toString().padLeft(2, '0')}";
                                                },
                                              ),
                                            )
                                          : SizedBox();
                                }),
                                SizedBox(height: paddingXs),
                                //name
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outlineVariant,
                                          border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline)),
                                      child: SizedBox(),
                                    ),
                                    SizedBox(
                                      width: paddingS,
                                    ),
                                    Text(
                                      "To Do",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurfaceVariant
                                                  .withValues(alpha: 0.25)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: paddingXs,
                                ),
                                CustomTextFormField(
                                  filled: false,
                                  maxLines: 4,
                                  login: false,
                                  controller: todolistController
                                      .taskDescriptionController,
                                  innerPadding: EdgeInsets.symmetric(
                                      vertical: paddingXs,
                                      horizontal: paddingXs),
                                  hintText: "Description",
                                ),
                                SizedBox(
                                  height: paddingS,
                                ),
                                Text(
                                  "RAPPEL",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant
                                              .withValues(alpha: 0.5)),
                                ),
                                SizedBox(height: paddingXs),
                                //date
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: CustomTextFormField(
                                        filled: false,
                                        readOnly: true,
                                        onTap: () {
                                          todolistController
                                              .showReminderDatePicker
                                              .toggle();
                                        },
                                        login: false,
                                        controller: todolistController
                                            .taskReminderDateController,
                                        prifixIcon: Icon(
                                          Icons.calendar_today,
                                          size: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: paddingS,
                                    ),
                                    Flexible(
                                      child: CustomTextFormField(
                                        filled: false,
                                        readOnly: true,
                                        onTap: () {
                                          todolistController
                                              .showReminderTimePicker
                                              .toggle();
                                        },
                                        controller: todolistController
                                            .taskReminderTimeController,
                                        login: false,
                                        prifixIcon: Icon(
                                          size: 18,
                                          Icons.schedule,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(() {
                                  return todolistController
                                              .showReminderDatePicker.value ==
                                          true
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: paddingXs),
                                          child: Center(
                                            child: Container(
                                              width: double.infinity,
                                              child: myDatePicker(
                                                  todolistController
                                                      .taskReminderDateController,
                                                  context),
                                            ),
                                          ),
                                        )
                                      : todolistController
                                                  .showReminderTimePicker
                                                  .value ==
                                              true
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: paddingXs),
                                              child: WheelTimePicker(
                                                initialTime: TimeOfDay.now(),
                                                onChanged: (newtime) {
                                                  todolistController
                                                          .taskReminderTimeController
                                                          .text =
                                                      "${newtime.hour.toString().padLeft(2, '0')}:${newtime.minute.toString().padLeft(2, '0')}";
                                                },
                                              ),
                                            )
                                          : SizedBox();
                                }),

                                SizedBox(
                                  height: paddingL,
                                ),
                                PrimaryButton(
                                  onTap: () {},
                                  text: "Ajouter Nouveau",
                                  prefixIcon:
                                      SvgPicture.asset("assets/plus.svg"),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    });
              },
              text: "Ajouter Nouveau",
              prefixIcon: SvgPicture.asset("assets/plus.svg"),
            ),
          )
        ],
      )),
    );
  }
}
