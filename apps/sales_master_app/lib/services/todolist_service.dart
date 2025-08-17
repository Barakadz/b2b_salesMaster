import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/todolist.dart';

class TodolistService {
  Future<Task?> getTaskById(int id) async {
    final response = await Api.getInstance().get("todolist/$id");
    if (response != null) {
      try {
        return Task.fromJson(response.data);
      } catch (e) {
        print("failed to parse task : $e");
      }
    }
    return null;
  }

  Future<PaginatedTodoList?> getTasks(
      {String? createdBy, String? query, bool? done}) async {
    final Map<String, dynamic> queryParams = {};

    if (createdBy != null && createdBy.trim().isNotEmpty) {
      queryParams['user_filter'] = createdBy.trim();
    }

    if (query != null && query.trim().isNotEmpty) {
      queryParams['search'] = query.trim();
    }
    if (done == true) {
      queryParams["done"] = done;
    }
    queryParams["per_page"] = 100;

    final response = await Api.getInstance()
        .get("todolist/assigned-to", queryParameters: queryParams);
    if (response != null) {
      try {
        return PaginatedTodoList.fromJson(response.data);
      } catch (e) {
        print("failed to parse todolist $e");
        rethrow;
      }
    }
    return null;
  }

  Future<bool> switchStatus(int id) async {
    try {
      final response =
          await Api.getInstance().post("todolist/$id/update-status");
      if (response?.data["success"] == true) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTask(int id) async {
    try {
      final response = await Api.getInstance().post("todolist/$id/delete");
      if (response?.data["success"] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print("print error deleting task");
      return false;
    }
  }

  Future<bool> createTask(
      {required String title,
      required String executionDateTime,
      String? location,
      String? reminderDateTime,
      required bool done,
      required int assignedToId,
      String? description,
      required String priority}) async {
    try {
      final body = {
        "title": title,
        "description": description,
        "priority": priority.toLowerCase(),
        "date_execution": executionDateTime,
        "assigned_to": assignedToId,
        "done": done,
        "location": location,
        "date_reminder": reminderDateTime
      };

      final response = await Api.getInstance().post("todolist/", data: body);

      return response != null;
    } catch (e) {
      print("Error in createTask: $e");
      return false;
    }
  }

  Future<bool> updateTask(
      {required int id,
      required String title,
      required String executionDateTime,
      String? location,
      String? reminderDateTime,
      required bool done,
      required int assignedToId,
      String? description,
      required String priority}) async {
    try {
      Map<String, dynamic> body = {
        "title": title,
        "description": description,
        "priority": priority.toLowerCase(),
        "date_execution": executionDateTime,
        "assigned_to": assignedToId,
        "done": false,
        "location": location,
        "date_reminder": reminderDateTime
      };
      final response =
          await Api.getInstance().put("todolist/$id/update", data: body);
      return response != null;
    } catch (e) {
      print("Error in updateTask: $e");
      return false;
    }
  }
}
