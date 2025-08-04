class OutlookReminder {
  String subject;
  String location;
  String date;
  String startTime;
  String endTime;
  String? description;

  OutlookReminder(
      {required this.subject,
      required this.location,
      required this.date,
      required this.startTime,
      required this.endTime,
      this.description});

  factory OutlookReminder.fromJson(Map<String, dynamic> json) {
    return OutlookReminder(
        subject: json["subject"],
        location: json["location"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        description: json["description"]);
  }
}
