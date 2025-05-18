class AppNotification {
  //int id;
  String title;
  String content;
  DateTime date;
  String type; //outlook , meeting...., todolist

  AppNotification(
      {required this.title,
      required this.content,
      required this.date,
      required this.type});

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
        title: json["title"],
        content: json["content"],
        date: json["date"],
        type: json["type"]);
  }
}
