class Realisation {
  double target;
  double currentValue;
  String name;

  Realisation({
    required this.target,
    required this.currentValue,
    required this.name,
  });

  factory Realisation.fromJson(Map<String, dynamic> json) {
    return Realisation(
        target: json["target"],
        currentValue: json["value"],
        name: json["name"]);
  }
}

class TotalRealisation {
  double increase;
  List<Realisation> realisations;

  TotalRealisation({required this.increase, required this.realisations});

  factory TotalRealisation.fromJson(Map<String, dynamic> json) {
    return TotalRealisation(
        increase: json["increase"],
        realisations: (json["realisations"] as List)
            .map((item) => Realisation.fromJson(json))
            .toList());
  }
}
