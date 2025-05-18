class Client {
  String companyName;
  String telecomManager;
  int openBills;
  int msisdnCount;
  double annualRevenue;
  double totalUnpaid;
  double lastBill;
  String msisdn;
  DateTime? expirationDate;
  bool isTopClient;

  Client(
      {required this.companyName,
      required this.telecomManager,
      required this.openBills,
      required this.msisdnCount,
      required this.annualRevenue,
      required this.totalUnpaid,
      required this.lastBill,
      required this.msisdn,
      required this.expirationDate,
      required this.isTopClient});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        companyName: json["raison_social"],
        telecomManager: json["telecom_manager"],
        openBills: json["facture_ouverte"],
        msisdnCount: json["nombre_de_lignes"],
        annualRevenue: json["revenu annuel"],
        totalUnpaid: json["montant_impayes"],
        lastBill: json["derniere_facture"],
        msisdn: json["msisdn"],
        isTopClient: json["topClient"],
        expirationDate: json["topClient"] == true
            ? DateTime.now().add(Duration(days: 30))
            : null);
  }
}
