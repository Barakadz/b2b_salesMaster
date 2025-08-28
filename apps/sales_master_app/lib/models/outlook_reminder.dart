class OutlookReminder {
  final String subject;
  final String location;
  final String date; // formatted: yyyy-MM-dd
  final String startTime; // formatted: HH:mm:ss
  final String endTime; // formatted: HH:mm:ss
  final String? description;

  OutlookReminder({
    required this.subject,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.description,
  });

  factory OutlookReminder.fromJson(Map<String, dynamic> json) {
    final startDateTime = DateTime.parse(json['start']['date']);
    final endDateTime = DateTime.parse(json['end']['date']);

    return OutlookReminder(
      subject: json['subject'] ?? '',
      location: json['location'] ?? '',
      date:
          "${startDateTime.year}-${startDateTime.month.toString().padLeft(2, '0')}-${startDateTime.day.toString().padLeft(2, '0')}",
      startTime:
          "${startDateTime.hour.toString().padLeft(2, '0')}:${startDateTime.minute.toString().padLeft(2, '0')}:${startDateTime.second.toString().padLeft(2, '0')}",
      endTime:
          "${endDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}:${endDateTime.second.toString().padLeft(2, '0')}",
      description: json['body'],
    );
  }
}
