// class Deal {
//   int id;
//   String raisonSociale;
//   String interlocuteur;
//   String numero;
//   String visitDate;
//   String nextVisittDate;
//   int status;
//   String mom;
//   String adresse;
//   String besoinType;
//   int raEstime;
//   String currentOperators;
//   String currentForfaits;
//   String mesureAccompagnement;
//   String nextVisitMotif;
//   String? besoinDetails;
//    Deal(
//       {required this.id,
//       required this.raisonSociale,
//       required this.interlocuteur,
//       required this.numero,
//       required this.visitDate,
//       required this.nextVisittDate,
//       required this.status,
//       required this.mom,
//       required this.adresse,
//       required this.besoinType,
//        required this.raEstime,
//       required this.currentOperators,
//       required this.currentForfaits,
//       required this.mesureAccompagnement,
//       required this.nextVisitMotif,
//        this.besoinDetails,

//        });

//   factory Deal.fromJson(Map<String, dynamic> json) {
//     return Deal(
//         id: json["id"],
//         raisonSociale: json["raison_social"],
//         interlocuteur: json["interlocutor_name"],
//         numero: json["numero_telephone"],
//         visitDate: json["last_visit_date"],
//         nextVisittDate: json["last_visit_date"],
//         status: json["status"],
//         mom: json["mom"] ,
//         adresse: json["adresse"],
//         besoinType: json["besoin_type"],
//          raEstime:json["ra_estime"],
//         currentOperators:json["current_operators"]["operator"],
//         currentForfaits:json["current_forfaits"]["forfait"],
//         mesureAccompagnement:json["mesure_accompagnement"],
//         nextVisitMotif:json["next_visit_motif"],
//         besoinDetails:json["besoin_details"],  
//          );
//   }
// }

// class PaginatedDeals {
//   int currentPage;
//   int lastPage;
//   int perPage;

//   final List<Deal> deals;

//   PaginatedDeals(
//       {required this.currentPage,
//       required this.lastPage,
//       required this.perPage,
//       required this.deals});

//   // factory PaginatedDeals.fromJson(Map<String, dynamic> json) {
//   //   return PaginatedDeals(
//   //     currentPage: json["current_page"],
//   //     lastPage: json["last_page"],
//   //     perPage: json["per_page"],
//   //     deals: (json['data'] as List).map((item) => Deal.fromJson(item)).toList(),
//   //   );
//   // }

//   factory PaginatedDeals.fromJson(Map<String, dynamic> json) {
//     final meta = json['meta'] ?? {};
//     final dataList = json['data'] as List? ?? [];

//     return PaginatedDeals(
//       currentPage: meta['current_page'] ?? 1,
//       lastPage: meta['last_page'] ?? 1,
//       perPage: meta['per_page'] ?? dataList.length,
//       deals: dataList.map((item) => Deal.fromJson(item)).toList(),
//     );
//   }
// }


class Deal {
  final int id;
  final String raisonSociale;
  final String interlocuteur;
  final String numero;
  final String visitDate;
  final String nextVisitDate;
  final String status;
  final String mom;
  final String adresse;
  final String besoinType;
  final int? raEstime;
  final String currentOperators;
  final String currentForfaits;
  final String? mesureAccompagnement;
  final String nextVisitMotif;
  final String? besoinDetails;

  Deal({
    required this.id,
    required this.raisonSociale,
    required this.interlocuteur,
    required this.numero,
    required this.visitDate,
    required this.nextVisitDate,
    required this.status,
    required this.mom,
    required this.adresse,
    required this.besoinType,
    required this.raEstime,
    required this.currentOperators,
    required this.currentForfaits,
    required this.mesureAccompagnement,
    required this.nextVisitMotif,
    this.besoinDetails,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    // Handle lists of operators and forfaits safely
    final operators = (json['current_operators'] as List?)
            ?.map((op) => op['operator'])
            .whereType<String>()
            .join(', ') ??
        '';

    final forfaits = (json['current_forfaits'] as List?)
            ?.map((f) => f['forfait'])
            .whereType<String>()
            .join(', ') ??
        '';

    return Deal(
      id: json["id"],
      raisonSociale: json["raison_social"] ?? '',
      interlocuteur: json["interlocutor_name"] ?? '',
      numero: json["numero_telephone"] ?? '',
      visitDate: json["last_visit_date"] ?? '',
      nextVisitDate: json["next_visit_date"] ?? '',
      status: json["status"] ?? '',
      mom: json["mom"] ?? '',
      adresse: json["adresse"] ?? '',
      besoinType: json["besoin_type"] ?? '',
      raEstime: json["ra_estime"],
      currentOperators: operators,
      currentForfaits: forfaits,
      mesureAccompagnement: json["mesure_accompagnement"],
      nextVisitMotif: json["next_visit_motif"] ?? '',
      besoinDetails: json["besoin_details"],
    );
  }
}
 
 
class PaginatedDeals {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final List<Deal> deals;
  final int total;

  PaginatedDeals({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.deals,
        required this.total,

  });

  factory PaginatedDeals.fromJson(Map<String, dynamic> json) {
    final meta = json['meta'] ?? {};
    final dataList = (json['data'] as List?) ?? [];

    return PaginatedDeals(
      currentPage: meta['current_page'] ?? 1,
      lastPage: meta['last_page'] ?? 1,
      perPage: meta['per_page'] ?? dataList.length,
      total: meta["total"],

      deals: dataList.map((item) => Deal.fromJson(item)).toList(),
    );
  }
}
