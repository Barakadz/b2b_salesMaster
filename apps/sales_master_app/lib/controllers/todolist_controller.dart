import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/controllers/currentuser_controller.dart';
import 'package:sales_master_app/models/todolist.dart';
import 'package:sales_master_app/services/todolist_service.dart';
import 'package:sales_master_app/services/utilities.dart';

// Optional: In case Get.context isn't ready early on
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class TodolistController extends GetxController {
  // Loading states
  Rx<bool> loadingTodolist = true.obs;
  Rx<bool> errorLoadingTodolist = false.obs;
  RxList<Task> todolist = <Task>[].obs;

  Rx<bool> editMode = false.obs;

  final Rxn<Task> editingTask = Rxn<Task>();

  Rx<bool> creatingTask = false.obs;
  Rx<String> selectedTaskFilter = "all".obs;
  RxList<String> taskFilter = ["all", "mine", "other"].obs;

  Rx<String> priority = "Low".obs;
  final List<String> priorities = ['Low', 'Medium', 'High'];

  RxList<Task> archiveTodolist = <Task>[].obs;
  Rx<bool> loadingArchiveTodolist = true.obs;
  Rx<bool> errorLoadingArchiveTodolist = true.obs;

  // Task creation state
  Rx<int> taskPriorityIndex = 1.obs;
  Rx<bool> showTaskDatePicker = false.obs;
  Rx<bool> showTasTimePicker = false.obs;
  Rx<bool> showReminderDatePicker = false.obs;
  Rx<bool> showReminderTimePicker = false.obs;

  bool taskDone = false;

  final GlobalKey<FormState> taskFormKey = GlobalKey<FormState>();

  CurrentuserController userController = Get.put(CurrentuserController());

  // Helpers
  final DateTime now = DateTime.now();
  final TimeOfDay nowTime = TimeOfDay.fromDateTime(DateTime.now());
  final DateTime nextWeek = DateTime.now().add(Duration(days: 7));
  final TimeOfDay defaultReminderTime =
      TimeOfDay(hour: 9, minute: 0); // example: 9:00 AM

  // Formatters
  String formatDate(DateTime date) =>
      "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  String formatTime(TimeOfDay time) =>
      time.format(Get.context ?? navigatorKey.currentContext!);

  // Controllers
  TextEditingController todolistSearchController = TextEditingController();
  TextEditingController todolistArchiveSearchController =
      TextEditingController();
  TextEditingController todolistLocationController = TextEditingController();
  TextEditingController todolistTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  late TextEditingController taskDateController;
  late TextEditingController tasktimeController;
  late TextEditingController taskReminderDateController;
  late TextEditingController taskReminderTimeController;

  Timer? _tasksDebounce;
  Timer? _archiveTsksDebounce;

  @override
  void onInit() {
    super.onInit();

    taskDateController = TextEditingController(text: formatDate(now));
    taskReminderDateController =
        TextEditingController(text: formatDate(nextWeek));

    tasktimeController = TextEditingController();
    taskReminderTimeController = TextEditingController();

    todolistSearchController.addListener(() {
      if (_tasksDebounce?.isActive ?? false) _tasksDebounce?.cancel();

      _tasksDebounce = Timer(const Duration(milliseconds: 700), () {
        loadTasks();
      });
    });

    todolistArchiveSearchController.addListener(() {
      if (_archiveTsksDebounce?.isActive ?? false)
        _archiveTsksDebounce?.cancel();

      _archiveTsksDebounce = Timer(const Duration(milliseconds: 700), () {
        loadArchiveTask();
      });
    });
  }

  int mapPriorityToIndex(String priority) {
    return priorities.indexOf(priority);
  }

  String mapIndexToPriority(int index) {
    return priorities[index];
  }

  void resetFields() {
    todolistTitleController.clear();
    taskDescriptionController.clear();
    todolistLocationController.clear();
    editingTask.value = null;
    taskDateController = TextEditingController(text: formatDate(now));
    taskReminderDateController =
        TextEditingController(text: formatDate(nextWeek));
    creatingTask.value = false;

    showTaskDatePicker = false.obs;
    showTasTimePicker = false.obs;
    showReminderDatePicker = false.obs;
    showReminderTimePicker = false.obs;
  }

  TimeOfDay timeFromDateTime(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  void fillFormFromTask(Task task) {
    showTaskDatePicker = false.obs;
    showTasTimePicker = false.obs;
    showReminderDatePicker = false.obs;
    showReminderTimePicker = false.obs;

    creatingTask.value = false;
    editingTask.value = task;

    todolistTitleController.text = task.title;
    taskDescriptionController.text = task.description ?? '';
    todolistLocationController.text = task.location ?? '';
    taskDone = task.done;

    // Handle task date & time
    if (task.executionDate != null && task.executionDate!.isNotEmpty) {
      try {
        DateTime parsedDate = DateTime.parse(task.executionDate!);
        taskDateController.text = formatDate(parsedDate); // e.g., "2025-07-07"
        // tasktimeController.text =
        //     formatTime(timeFromDateTime(parsedDate)); // e.g., "15:30"

        tasktimeController.text = task.executionTime;
      } catch (e) {
        taskDateController.text = formatDate(DateTime.now());
        tasktimeController.text = '';
      }
    } else {
      taskDateController.text = formatDate(DateTime.now());
      tasktimeController.text = '';
    }

    if (task.reminderDate != null && task.reminderDate!.isNotEmpty) {
      try {
        DateTime parsedReminder = DateTime.parse(task.reminderDate!);
        taskReminderDateController.text = formatDate(parsedReminder);
        // taskReminderTimeController.text =
        //     formatTime(timeFromDateTime(parsedReminder));
        taskReminderTimeController.text = task.reminderDateTime!;
      } catch (e) {
        taskReminderDateController.text =
            formatDate(DateTime.now().add(Duration(days: 7)));
        taskReminderTimeController.text = '';
      }
    } else {
      taskReminderDateController.text =
          formatDate(DateTime.now().add(Duration(days: 7)));
      taskReminderTimeController.text = '';
    }

    priority.value = task.priority;
    taskPriorityIndex.value = mapPriorityToIndex(task.priority);
  }

  @override
  void onReady() {
    super.onReady();

    // Set time texts now that context is available
    tasktimeController.text = formatTime(nowTime);
    taskReminderTimeController.text = formatTime(defaultReminderTime);
  }

  @override
  void onClose() {
    todolistSearchController.dispose();
    taskDescriptionController.dispose();
    taskDateController.dispose();
    tasktimeController.dispose();
    taskReminderDateController.dispose();
    taskReminderTimeController.dispose();

    todolistSearchController.dispose();
    todolistArchiveSearchController.dispose();
    _tasksDebounce?.cancel();
    _archiveTsksDebounce?.cancel();

    super.onClose();
  }

  void switchTaskPriority(int index) {
    taskPriorityIndex.value = index;
  }

  void switchTaskType(String name) {
    if (name != selectedTaskFilter.value) {
      selectedTaskFilter.value = name;
      loadTasks();
    }
  }

  String? validateTaskTitle(String? title) {
    if (isEmpty(title)) {
      return "please enter title";
    }
    return null;
  }

  void togglecheck(int index) async {
    final initialTask = todolist[index];
    final updatedTask = initialTask.copyWith(done: !initialTask.done);
    todolist[index] = updatedTask;

    bool apiResponse =
        await TodolistService().switchStatus(initialTask.id, updatedTask.done);
    if (!apiResponse) {
      todolist[index] = initialTask;
      todolist.refresh();
    }
  }

  Future<void> loadFakeTodolist() async {
    loadingTodolist.value = true;
    errorLoadingTodolist.value = false;
    await Future.delayed(Duration(seconds: 3));
    todolist.assignAll([
      Task(
          id: 1,
          title: "Prospection à l’entreprise ADE",
          location: "Dar El Beïda, Alger",
          executionDate: "Avril 25, 2025",
          executionTime: "11:30 AM",
          done: false,
          selfAssigned: true,
          assignedTo: "Ryade ALOUANE",
          priority: "Low",
          assignedBy: "Ryade ALOUANE"),
      Task(
          id: 2,
          title: "Prospection à l’entreprise ADE",
          location: "Dar El Beïda, Alger",
          executionDate: "Avril 25, 2025",
          executionTime: "11:30 AM",
          done: false,
          priority: "High",
          selfAssigned: false,
          assignedTo: "Ryade ALOUANE",
          assignedBy: "someone"),
      Task(
          id: 3,
          title: "Prospection à l’entreprise ADE",
          location: "Dar El Beïda, Alger",
          executionDate: "Avril 25, 2025",
          executionTime: "11:30 AM",
          priority: "Medium",
          done: false,
          selfAssigned: false,
          assignedTo: "Ryade ALOUANE",
          assignedBy: "someone"),
      Task(
          id: 4,
          title: "Prospection à l’entreprise ADE",
          location: "Dar El Beïda, Alger",
          executionDate: "Avril 25, 2025",
          executionTime: "11:30 AM",
          done: true,
          selfAssigned: true,
          assignedTo: "Ryade ALOUANE",
          priority: "Low",
          assignedBy: "Ryade ALOUANE"),
    ]);
    loadingTodolist.value = false;
    errorLoadingTodolist.value = false;
  }

  String? validateTaskDate(String? date) {
    if (isEmpty(date)) {
      return "pick a date";
    }
    return null;
  }

  String? validateTaskTime(String? time) {
    if (isEmpty(time)) {
      return "pick a time";
    }
    return null;
  }

  Future<void> loadTasks() async {
    loadingTodolist.value = true;
    errorLoadingTodolist.value = false;
    PaginatedTodoList? allTasks = await TodolistService().getTasks(
        createdBy: selectedTaskFilter.value,
        query: todolistSearchController.text);
    if (allTasks != null) {
      todolist.assignAll(allTasks.tasks);
      todolist.refresh();
    } else {
      errorLoadingTodolist.value = true;
    }
    loadingTodolist.value = false;
  }

  Future<void> loadArchiveTask() async {
    loadingArchiveTodolist.value = true;
    errorLoadingArchiveTodolist.value = false;
    PaginatedTodoList? allTasks = await TodolistService().getTasks(
        createdBy: "all",
        query: todolistArchiveSearchController.text,
        done: true);
    if (allTasks != null) {
      archiveTodolist.assignAll(allTasks.tasks);
      archiveTodolist.refresh();
    } else {
      errorLoadingArchiveTodolist.value = true;
    }
    loadingArchiveTodolist.value = false;
  }

  void deleteTask(Task task) async {
    int index = todolist.indexWhere((t) => t.id == task.id);
    if (index == -1) return;

    Task deletedTask = todolist.removeAt(index);
    bool apiResponse = await TodolistService().deleteTask(task.id);

    if (!apiResponse) {
      todolist.insert(index, deletedTask);
      todolist.refresh();
      //Get.snackbar("Erreur", "Échec de la suppression");
    }
  }

  Future<void> loadFakeArchiveTodolist() async {
    loadingArchiveTodolist.value = true;
    errorLoadingArchiveTodolist.value = false;
    await Future.delayed(Duration(seconds: 3));
    archiveTodolist.assignAll([
      Task(
          id: 7,
          title: "Prospection à l’entreprise ADE",
          location: "Dar El Beïda, Alger",
          executionDate: "Avril 25, 2025",
          executionTime: "11:30 AM",
          done: true,
          selfAssigned: true,
          assignedTo: "Ryade ALOUANE",
          priority: "Low",
          assignedBy: "Ryade ALOUANE"),
      Task(
          id: 8,
          title: "Prospection à l’entreprise ADE",
          location: "Dar El Beïda, Alger",
          executionDate: "Avril 25, 2025",
          executionTime: "11:30 AM",
          done: true,
          priority: "High",
          selfAssigned: false,
          assignedTo: "Ryade ALOUANE",
          assignedBy: "someone"),
      Task(
          id: 9,
          title: "Prospection à l’entreprise ADE",
          location: "Dar El Beïda, Alger",
          executionDate: "Avril 25, 2025",
          executionTime: "11:30 AM",
          priority: "Medium",
          done: true,
          selfAssigned: false,
          assignedTo: "Ryade ALOUANE",
          assignedBy: "someone"),
      Task(
          id: 10,
          title: "Prospection à l’entreprise ADE",
          location: "Dar El Beïda, Alger",
          executionDate: "Avril 25, 2025",
          executionTime: "11:30 AM",
          done: true,
          selfAssigned: true,
          assignedTo: "Ryade ALOUANE",
          priority: "Low",
          assignedBy: "Ryade ALOUANE"),
    ]);
    loadingArchiveTodolist.value = false;
    errorLoadingArchiveTodolist.value = false;
  }

  Future<bool> createNewTask() async {
    if (taskFormKey.currentState!.validate() != true) {
      return false;
    }
    if (creatingTask.value == true) {
      return false;
    }
    creatingTask.value = true;
    bool res = await TodolistService().createTask(
        title: todolistTitleController.text,
        description: taskDescriptionController.text,
        location: todolistLocationController.text,
        executionDateTime:
            "${taskDateController.text} ${tasktimeController.text}",
        done: false,
        assignedToId: userController.currentUser.value?.id ?? 0,
        reminderDateTime: taskReminderDateController.isBlank == true ||
                taskReminderTimeController.isBlank == true
            ? null
            : "${taskReminderDateController.text} ${taskReminderTimeController.text}",
        priority: priority.value);
    creatingTask.value = false;
    if (res == true) {
      loadTasks();
    }
    return res;
  }

  Future<bool> editTask() async {
    if (taskFormKey.currentState!.validate() != true) {
      return false;
    }
    if (creatingTask.value == true || editingTask.value == null) {
      return false;
    }
    creatingTask.value = true;
    bool res = await TodolistService().updateTask(
        id: editingTask.value!.id,
        title: todolistTitleController.text,
        description: taskDescriptionController.text,
        location: todolistLocationController.text,
        executionDateTime:
            "${taskDateController.text} ${tasktimeController.text}",
        done: taskDone,
        assignedToId: userController.currentUser.value?.id ?? 0,
        reminderDateTime: taskReminderDateController.isBlank == true ||
                taskReminderTimeController.isBlank == true
            ? null
            : "${taskReminderDateController.text} ${taskReminderTimeController.text}",
        priority: priority.value);
    creatingTask.value = false;
    if (res == true) {
      loadTasks();
    }
    return res;
  }
}
