import 'dart:convert';

import 'package:sales_master_app/config/routes.dart';

final Map<int, String> notificationRouteMap = {
  1: AppRoutes.todolist.path, // task_reminder_30d
  11: AppRoutes.todolist.path, // task_assigned

  3: AppRoutes.dealsScreen.path, // followup_reminder_1m

  4: AppRoutes.myClients.path, // data_update_bad_debt

  5: AppRoutes.catalogue.path, // data_update_catalog
  6: AppRoutes.catalogue.path, // data_update_benchmark
  7: AppRoutes.catalogue.path, // data_update_roaming

  9: AppRoutes.dashboardRealisations.path, // data_update_goals
  10: AppRoutes.dashboardRealisations.path, // goal_progress_70pct
};

class AppNotification {
  final String id;
  final int categoryId;
  final String title;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppNotification({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    // decode the nested string JSON
    final Map<String, dynamic> innerData = jsonDecode(json['data']);

    return AppNotification(
      id: json['id'],
      categoryId: json['category_id'],
      title: innerData['title'] ?? '',
      message: innerData['message'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  /// Returns the route associated with this notification
  String? get route => notificationRouteMap[categoryId];
}

class PaginatedNotifications {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final List<AppNotification> notifications;
  final int undreadCount;

  PaginatedNotifications({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.notifications,
    required this.undreadCount,
  });

  factory PaginatedNotifications.fromJson(Map<String, dynamic> json) {
    final data = json['data']['data'] as List;
    final meta = json['data']['meta'];

    return PaginatedNotifications(
      currentPage: meta['current_page'],
      lastPage: meta['last_page'],
      perPage: meta['per_page'],
      undreadCount: json["data"]["unread-count"] ?? 0,
      notifications:
          data.map((item) => AppNotification.fromJson(item)).toList(),
    );
  }
}
