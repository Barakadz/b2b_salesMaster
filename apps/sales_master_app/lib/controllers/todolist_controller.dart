import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/models/todolist.dart';
import 'package:sales_master_app/services/todolist_service.dart';

// Optional: In case Get.context isn't ready early on
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class TodolistController extends GetxController {
  // Loading states
  Rx<bool> loadingTodolist = true.obs;
  Rx<bool> errorLoadingTodolist = false.obs;
  RxList<Task> todolist = <Task>[].obs;

  RxList<Task> archiveTodolist = <Task>[].obs;
  Rx<bool> loadingArchiveTodolist = true.obs;
  Rx<bool> errorLoadingArchiveTodolist = true.obs;

  // Task creation state
  Rx<int> newTaskSatatusIndex = 1.obs;
  Rx<bool> showTaskDatePicker = false.obs;
  Rx<bool> showTasTimePicker = false.obs;
  Rx<bool> showReminderDatePicker = false.obs;
  Rx<bool> showReminderTimePicker = false.obs;

  Rx<String> typeFilter = "All".obs;

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
  TextEditingController taskDescriptionController = TextEditingController();
  late TextEditingController taskDateController;
  late TextEditingController tasktimeController;
  late TextEditingController taskReminderDateController;
  late TextEditingController taskReminderTimeController;

  @override
  void onInit() {
    super.onInit();

    // Initialize text controllers with default values
    taskDateController = TextEditingController(text: formatDate(now));
    taskReminderDateController =
        TextEditingController(text: formatDate(nextWeek));

    // These need context — assign them in onReady()
    tasktimeController = TextEditingController();
    taskReminderTimeController = TextEditingController();
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
    super.onClose();
  }

  void switchNewTaskIndex(int index) {
    newTaskSatatusIndex.value = index;
  }

  void togglecheck(int index) {
    final current = todolist[index];
    final updated = current.copyWith(done: !current.done);
    todolist[index] = updated;
  }

  void loadFakeTodolist() async {
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

  void loadTasks() async {
    loadingTodolist.value = true;
    errorLoadingTodolist.value = false;
    PaginatedTodoList? allTasks = await TodolistService().getAllMyTasks();
    if (allTasks != null) {
      todolist.assignAll(allTasks.tasks);
      todolist.refresh();
    } else {
      errorLoadingTodolist.value = true;
    }
    loadingTodolist.value = false;
  }

  void deleteTask(int id, int index) async {
    Task deletedTask = todolist.removeAt(index);
    bool apiResponse = await TodolistService().deleteTask(id);
    if (apiResponse == false) {
      todolist.insert(index, deletedTask);
      todolist.refresh();
    }
  }

  void loadFakeArchiveTodolist() async {
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
}
