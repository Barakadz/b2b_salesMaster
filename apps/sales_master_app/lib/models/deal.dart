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
        raisonSociale: json["raison_social"],
        interlocuteur: json["interlocutor_name"],
        numero: json["numero_telephone"],
        visitDate: json["last_visit_date"],
        nextVisittDate: json["last_visit_date"],
        status: json["status"],
        mom: json["mom"]);
  }
}

class PaginatedDeals {
  int currentPage;
  int lastPage;
  int perPage;

  final List<Deal> deals;

  PaginatedDeals(
      {required this.currentPage,
      required this.lastPage,
      required this.perPage,
      required this.deals});

  factory PaginatedDeals.fromJson(Map<String, dynamic> json) {
    return PaginatedDeals(
      currentPage: json["current_page"],
      lastPage: json["last_page"],
      perPage: json["per_page"],
      deals: (json['data'] as List).map((item) => Deal.fromJson(item)).toList(),
    );
  }
}
