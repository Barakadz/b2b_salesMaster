class PipelinePerformance {
  int id;
  double priseContact;
  double depotDoffre;
  double enCours;
  double conclusion;
  double onHold;
  double globalValue;
  bool raise;

  PipelinePerformance(
      {required this.id,
      required this.priseContact,
      required this.depotDoffre,
      required this.enCours,
      required this.conclusion,
      required this.globalValue,
      required this.raise,
      required this.onHold});

  factory PipelinePerformance.fromJson(Map<String, dynamic> json) {
    return PipelinePerformance(
        id: json["id"],
        globalValue: json["globalDue"],
        raise: json["raise"],
        priseContact: json["priseContact"],
        depotDoffre: json["depotDoffre"],
        enCours: json["enCours"],
        conclusion: json["conclusion"],
        onHold: json["onHold"]);
  }
}
