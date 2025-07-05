class Deal {
  int id;
  String raisonSociale;
  String interlocuteur;
  String numero;
  String visitDate;
  String nextVisittDate;
  String status;
  String mom;

  Deal(
      {required this.id,
      required this.raisonSociale,
      required this.interlocuteur,
      required this.numero,
      required this.visitDate,
      required this.nextVisittDate,
      required this.status,
      required this.mom});

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
        id: json["id"],
        raisonSociale: json["raisonSociale"],
        interlocuteur: json["interlocuteur"],
        numero: json["numero"],
        visitDate: json["visitDate"],
        nextVisittDate: json["nextVisittDate"],
        status: json["status"],
        mom: json["mom"]);
  }
}
