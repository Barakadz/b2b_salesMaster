class Client {
  int id;
  String companyName;
  String telecomManager;
  int openBills;
  int msisdnCount;
  double annualRevenue;
  double totalUnpaid;
  double globalDueAj;
  double lastBill;
  String msisdn;
  DateTime? expirationDate;
  bool isTopClient;
  bool active;
  int offers;
  String reconduction;
  String? mom;

  Client(
      {required this.id,
      required this.companyName,
      required this.telecomManager,
      required this.openBills,
      required this.msisdnCount,
      required this.annualRevenue,
      required this.totalUnpaid,
      required this.lastBill,
      required this.msisdn,
      required this.expirationDate,
      required this.active,
      required this.offers,
      required this.globalDueAj,
      required this.reconduction,
      this.mom,
      required this.isTopClient});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        id: json["id"],
        companyName: json["raison_social"],
        telecomManager: json["telecom_manager"],
        openBills: json["facture_ouverte"],
        msisdnCount: json["nombre_de_lignes"],
        annualRevenue: json["revenu annuel"],
        totalUnpaid: json["montant_impayes"],
        lastBill: json["derniere_facture"],
        msisdn: json["msisdn"],
        isTopClient: json["topClient"],
        active: json["active"],
        globalDueAj: json["due_aj"],
        offers: json["offers"],
        mom: json["mom"],
        reconduction: json["reconduction"],
        expirationDate: json["topClient"] == true
            ? DateTime.now().add(Duration(days: 30))
            : null);
  }
}

class PaginatedClient {
  final List<Client> clients;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  PaginatedClient({
    required this.clients,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PaginatedClient.fromJson(Map<String, dynamic> json) {
    return PaginatedClient(
      clients: (json["data"] as List)
          .map((clientJson) => Client.fromJson(clientJson))
          .toList(),
      currentPage: json["current_page"],
      lastPage: json["last_page"],
      perPage: json["per_page"],
      total: json["total"],
    );
  }
}
