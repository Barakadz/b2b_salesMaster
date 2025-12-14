class DealStatus {
  int id;
  String name;

  DealStatus({required this.id, required this.name});

  factory DealStatus.fromJson(Map<String, dynamic> json) {
    return DealStatus(id: json["data"], name: json["name"]);
  }
}
class BesoinStatus {
  int id;
  String name;

  BesoinStatus({required this.id, required this.name});

  factory BesoinStatus.fromJson(Map<String, dynamic> json) {
    return BesoinStatus(id: json["data"], name: json["name"]);
  }
}
