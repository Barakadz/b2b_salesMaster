import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/config/todolist_status_style.dart';
import 'package:sales_master_app/controllers/todolist_controller.dart';
import 'package:sales_master_app/widgets/custom_app_drawer.dart';
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
    TodolistStatusStyle style = controller.taskPriorityIndex.value == index
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
        controller.switchTaskPriority(index);
        controller.priority.value = name;
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

  void openTaskBottomSheet(
      BuildContext context, TodolistController todolistController) {
    showModalBottomSheet(
        isScrollControlled: true,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.8),
        useSafeArea: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
        ),
        context: context,
        //enableDrag: true,
        //showDragHandle: true,
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.outlineVariant,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(paddingL),
              child: SingleChildScrollView(
                child: Form(
                  key: todolistController.taskFormKey,
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
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(
                            width: paddingS,
                          ),
                          Text(
                              todolistController.editingTask.value != null
                                  ? "Modifier La tache"
                                  : "Ajouter une tache",
                              style: Theme.of(context).textTheme.titleLarge)
                        ],
                      ),
                      SizedBox(
                        height: paddingS,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() {
                            return chipBuilder(
                                "Low", 0, context, todolistController);
                          }),
                          Obx(() {
                            return chipBuilder(
                                "Medium", 1, context, todolistController);
                          }),
                          Obx(() {
                            return chipBuilder(
                                "High", 2, context, todolistController);
                          })
                        ],
                      ),
                      SizedBox(
                        height: paddingS,
                      ),
                      Text(
                        "DATE",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                                todolistController.showTasTimePicker.value =
                                    false;
                                todolistController.showTaskDatePicker.toggle();
                              },
                              filled: false,
                              readOnly: true,
                              controller: todolistController.taskDateController,
                              login: false,
                              validator: (String? date) {
                                return todolistController
                                    .validateTaskDate(date);
                              },
                              prifixIcon: Icon(
                                size: 18,
                                Icons.calendar_today,
                                color: Theme.of(context).colorScheme.primary,
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
                                todolistController.showTaskDatePicker.value =
                                    false;
                                todolistController.showTasTimePicker.toggle();
                              },
                              controller: todolistController.tasktimeController,
                              login: false,
                              validator: (String? time) {
                                return todolistController
                                    .validateTaskTime(time);
                              },
                              prifixIcon: Icon(
                                size: 18,
                                Icons.schedule,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(() {
                        return todolistController.showTaskDatePicker.value ==
                                true
                            ? Padding(
                                padding: const EdgeInsets.only(top: paddingXs),
                                child: Center(
                                  child: Container(
                                    width: double.infinity,
                                    child: myDatePicker(
                                        todolistController.taskDateController,
                                        context),
                                  ),
                                ),
                              )
                            : todolistController.showTasTimePicker.value == true
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(top: paddingXs),
                                    child: WheelTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      onChanged: (newtime) {
                                        todolistController
                                                .tasktimeController.text =
                                            "${newtime.hour.toString().padLeft(2, '0')}:${newtime.minute.toString().padLeft(2, '0')}";
                                      },
                                    ),
                                  )
                                : SizedBox();
                      }),
                      SizedBox(height: paddingXs),
                      //name
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    color:
                                        Theme.of(context).colorScheme.outline)),
                            child: SizedBox(),
                          ),
                          SizedBox(
                            width: paddingS,
                          ),
                          Flexible(
                            child: CustomTextFormField(
                              outlineColor: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withValues(alpha: 0),
                              hintText: "To Do",
                              controller:
                                  todolistController.todolistTitleController,
                              validator: (String? title) {
                                return todolistController
                                    .validateTaskTitle(title);
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: paddingXs,
                      ),
                      CustomTextFormField(
                        filled: false,
                        maxLines: 4,
                        login: false,
                        controller:
                            todolistController.taskDescriptionController,
                        innerPadding: EdgeInsets.symmetric(
                            vertical: paddingXs, horizontal: paddingXs),
                        hintText: "Description",
                        outlineColor: Theme.of(context)
                            .colorScheme
                            .outline
                            .withValues(alpha: 0),
                      ),
                      SizedBox(
                        height: paddingS,
                      ),
                      Text(
                        "ADDRESS",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withValues(alpha: 0.5)),
                      ),
                      SizedBox(
                        height: paddingXs,
                      ),
                      CustomTextFormField(
                        filled: false,
                        login: false,
                        prifixIcon: Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        controller:
                            todolistController.todolistLocationController,
                        innerPadding: EdgeInsets.symmetric(
                            vertical: paddingXs, horizontal: paddingXs),
                        hintText: "Address",
                      ),

                      SizedBox(
                        height: paddingS,
                      ),
                      Text(
                        "RAPPEL",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                                todolistController.showReminderDatePicker
                                    .toggle();
                              },
                              login: false,
                              //validator: (String date){},
                              controller:
                                  todolistController.taskReminderDateController,
                              prifixIcon: Icon(
                                Icons.calendar_today,
                                size: 18,
                                color: Theme.of(context).colorScheme.primary,
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
                                todolistController.showReminderTimePicker
                                    .toggle();
                              },
                              controller:
                                  todolistController.taskReminderTimeController,
                              login: false,
                              prifixIcon: Icon(
                                size: 18,
                                Icons.schedule,
                                color: Theme.of(context).colorScheme.primary,
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
                                padding: const EdgeInsets.only(top: paddingXs),
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
                            : todolistController.showReminderTimePicker.value ==
                                    true
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(top: paddingXs),
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
                      Obx(() {
                        return PrimaryButton(
                          onTap: () async {
                            bool res =
                                todolistController.editingTask.value == null
                                    ? await todolistController.createNewTask()
                                    : await todolistController.editTask();

                            if (res == true) {
                              // pop;
                            }
                          },
                          text: todolistController.editingTask.value != null
                              ? "Modifier tache"
                              : "Ajouter Nouvelle",
                          loading: todolistController.creatingTask.value,
                          prefixIcon: SvgPicture.asset("assets/plus.svg"),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    TodolistController todolistController = Get.put(TodolistController());
    todolistController.loadFakeTodolist();
    // todolistController.loadTasks();
    return Scaffold(
      drawer: CustomAppDrawer(),
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
                IntrinsicWidth(
                  child: Obx(() {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Padding(
                          padding: EdgeInsets.symmetric(horizontal: paddingXs),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: paddingXs),
                            child: Text(
                              'type',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                        items: todolistController.taskFilter
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: paddingXs),
                                    child: Text(
                                      item,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: todolistController.selectedTaskFilter.value,
                        onChanged: (String? name) {
                          if (name != null) {
                            todolistController.switchTaskType(name);
                          }
                        },
                        buttonStyleData: ButtonStyleData(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(borderRadiusSmall),
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer)),
                          padding: const EdgeInsets.only(left: 0, right: 8),
                          height: 35,
                          width: double.infinity,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 35,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  width: paddingXs,
                ),
                GestureDetector(
                  onTap: () {
                    todolistController.todolistArchiveSearchController.clear();
                    context.go(AppRoutes.todolistArchive.path);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(borderRadiusSmall),
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiaryContainer
                                .withValues(alpha: 0.8))),
                    child: Padding(
                      padding: const EdgeInsets.all(paddingXxs),
                      child: SvgPicture.asset(
                        "assets/archive.svg",
                        width: 23,
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
            child: RefreshIndicator(
              onRefresh: () => todolistController.loadFakeTodolist(),
              child: Obx(() {
                return ListView.builder(
                    itemCount: todolistController.todolist.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        confirmDismiss: (direction) async => true,
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          todolistController
                              .deleteTask(todolistController.todolist[index]);
                        },
                        background: Container(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.05),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: paddingS),
                            child: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        child: TodolistCard(
                            onClicked: () {
                              todolistController.fillFormFromTask(
                                  todolistController.todolist[index]);
                              openTaskBottomSheet(context, todolistController);
                            },
                            onChecked: () {
                              todolistController.togglecheck(index);
                            },
                            todolist: todolistController.todolist[index]),
                      );
                    });
              }),
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: paddingL, vertical: paddingS),
            child: PrimaryButton(
              onTap: () {
                todolistController.resetFields();
                openTaskBottomSheet(context, todolistController);
              },
              text: "Ajouter Nouvelle",
              prefixIcon: SvgPicture.asset("assets/plus.svg"),
            ),
          )
        ],
      )),
    );
  }
}
