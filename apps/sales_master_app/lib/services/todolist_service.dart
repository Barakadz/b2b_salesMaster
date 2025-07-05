import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/todolist.dart';

class TodolistService {
  Future<Task?> getTaskById(int id) async {
    final response = await Api.getInstance().get("api//");
    if (response != null) {
      try {
        return Task.fromJson(response.data);
      } catch (e) {
        print("failed to parse task : $e");
      }
    }
    return null;
  }

  Future<PaginatedTodoList?> getAllMyTasks() async {
    final response = await Api.getInstance().get("todolist/assigned-to");
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

  Future<bool> deleteTask(int id) async {
    try {
      final response =
          await Api.getInstance().delete("msisdn.../todolist/$id/delete");
      if (response != null) {
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
        "priority": priority,
        "date_execution": executionDateTime,
        "assgined_to": assignedToId,
        "status_id": done == true ? 2 : 1,
        "location": location,
        "date_reminder": reminderDateTime
      };

      final response =
          await Api.getInstance().post("api/dist/customers/", data: body);

      return response != null;
    } catch (e) {
      print("Error in createTask: $e");
      return false;
    }
  }

  Future<bool> updateTask() async {
    try {
      Map<String, dynamic> body = {};
      final response =
          await Api.getInstance().put("api/dist/tasks//", data: body);
      return response != null;
    } catch (e) {
      print("Error in updateTask: $e");
      return false;
    }
  }
}
