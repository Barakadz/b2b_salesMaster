import 'package:get/get.dart';
import 'package:sales_master_app/extensions/string_extension.dart';

class Task {
  int id;
  String title;
  String? description;
  String? location;
  String executionDate;
  String executionTime;
  String? reminderDate;
  String? reminderDateTime;
  bool done;
  bool selfAssigned;
  String? assignedTo;
  String assignedBy;
  String priority;

  Task(
      {required this.id,
      required this.title,
      this.location,
      required this.executionDate,
      required this.executionTime,
      required this.done,
      required this.selfAssigned,
      this.assignedTo,
      required this.assignedBy,
      this.reminderDate,
      this.reminderDateTime,
      this.description,
      required this.priority});

  // factory Task.fromJson(Map<String, dynamic> json) {
  //   final assignedValue = json['assigned_by_user'];
  //   return Task(
  //       id: json["id"],
  //       title: json["title"],
  //       description: json["description"],
  //       location: json["location"],
  //       executionDate: json["execution_date"].toString().substring(0, 10),
  //       executionTime: json["execution_date"].toString().substring(11, 19),
  //       reminderDate: json["reminder_date"].toString().substring(0, 10),
  //       reminderDateTime: json["reminder_date"].toString().substring(11, 19),
  //       done: json["done"],
  //       selfAssigned: assignedValue is String,
  //       assignedBy: assignedValue is String
  //           ? json["assigned_by_user"]
  //           : "${json["assigned_by_user"]["lastName"]} ${json["assigned_by_user"]["firstName"]}",
  //       priority: json["priority"].toString().toTitleCase);
  // }

  factory Task.fromJson(Map<String, dynamic> json) {
    final assignedValue = json['assigned_by_user'];

    final executionDateTime = json["execution_date"]?.toString();
    final reminderDateTime = json["reminder_date"]?.toString();

    return Task(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      location: json["location"],
      executionDate: executionDateTime != null && executionDateTime.length >= 10
          ? executionDateTime.substring(0, 10)
          : "",
      executionTime: executionDateTime != null && executionDateTime.length >= 19
          ? executionDateTime.substring(11, 19)
          : "",
      reminderDate: reminderDateTime != null && reminderDateTime.length >= 10
          ? reminderDateTime.substring(0, 10)
          : null,
      reminderDateTime:
          reminderDateTime != null && reminderDateTime.length >= 19
              ? reminderDateTime.substring(11, 19)
              : null,
      done: json["done"] ?? false,
      selfAssigned: assignedValue is String,
      assignedBy: assignedValue is String
          ? assignedValue
          : "${assignedValue?["lastName"] ?? ""} ${assignedValue?["firstName"] ?? ""}"
              .trim(),
      priority: json["priority"]?.toString().toTitleCase ?? "",
    );
  }

  Task copyWith({bool? done}) {
    return Task(
      id: id,
      title: title,
      location: location,
      executionDate: executionDate,
      executionTime: executionTime,
      reminderDate: reminderDate,
      reminderDateTime: reminderDateTime,
      selfAssigned: selfAssigned,
      assignedTo: assignedTo,
      assignedBy: assignedBy,
      priority: priority,
      done: done ?? this.done,
    );
  }
}

class PaginatedTodoList {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final String? next;
  final String? previous;
  final List<Task> tasks;

  PaginatedTodoList({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.next,
    this.previous,
    required this.tasks,
  });

  factory PaginatedTodoList.fromJson(Map<String, dynamic> json) {
    final data = json["data"];
    final meta = data["meta"];

    return PaginatedTodoList(
      currentPage: meta["current_page"],
      lastPage: meta["last_page"],
      perPage: meta["per_page"],
      total: meta["total"],
      next: meta["next_page_url"],
      previous: meta["prev_page_url"],
      tasks: (data["data"] as List).map((item) => Task.fromJson(item)).toList(),
    );
  }
}
