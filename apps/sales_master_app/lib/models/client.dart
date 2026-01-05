class ClientListItem {
  int id;
  String name;
  bool isTopClient;
  bool isActive;
  int msisdnCount;

  ClientListItem(
      {required this.id,
      required this.name,
      required this.isTopClient,
      required this.msisdnCount,
      required this.isActive});

  factory ClientListItem.fromJson(Map<String, dynamic> json) {
    return ClientListItem(
        id: json["id"],
        name: json["client"],
        msisdnCount: json["nombre_ligne"],
        isTopClient: json["top1000"] == true,
        isActive: json["status"] == "active");
  }
}

class PaginatedClientListItem {
  final List<ClientListItem> clients;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  PaginatedClientListItem({
    required this.clients,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PaginatedClientListItem.fromJson(Map<String, dynamic> json) {
    final data = json["data"];
    final meta = data["meta"];

    return PaginatedClientListItem(
      clients: (data["data"] as List)
          .map((clientJson) => ClientListItem.fromJson(clientJson))
          .toList(),
      currentPage: meta["current_page"],
      lastPage: meta["last_page"],
      perPage: meta["per_page"],
      total: meta["total"],
    );
  }
}
class Offer {
  final String packageCode;
  final String? packageId;

  Offer({
    required this.packageCode,
    this.packageId,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      packageCode: json['package_code'] ?? '',
      packageId: json['package_id']?.toString(),
    );
  }
}

class ClientDetails {
  final int id;
  final String raisonSociale;
  final String? createdAt;
  final String? updatedAt;
  final String payerId;
  final String payerName;
  final String payerSize;
  final String payerActivationDate;
  final String payerStatus;
  final String payerCategory;
  final String payerCollectorId;
  final String region;
  final dynamic mainPackageFee;
  final dynamic monthlyFee;
  final dynamic speedFee;
  final dynamic dispatcherLicenseFee;
  final dynamic dispatcherServiceFee;
  final dynamic pptServiceFee;
  final dynamic monthlyFeeGlobal;
  final String? expiryDateTop1000;
  final int saleId;
  final String status;
  final int nombreLigne;
  final int nombreOffre;
  final double monthlyRevenu;
  final dynamic tm;
  final Bill? bill;
  final String? mom;
final String? lastVisiteDate;
final List<Offer> allOffers;
  ClientDetails(
      {required this.id,
      required this.raisonSociale,
      this.createdAt,
      this.updatedAt,
      required this.payerId,
      required this.payerName,
      required this.payerSize,
      required this.payerActivationDate,
      required this.payerStatus,
      required this.payerCategory,
      required this.payerCollectorId,
      required this.region,
      this.mainPackageFee,
      this.monthlyFee,
      this.speedFee,
      this.dispatcherLicenseFee,
      this.dispatcherServiceFee,
      this.pptServiceFee,
      this.monthlyFeeGlobal,
      this.expiryDateTop1000,
      required this.saleId,
      required this.status,
      required this.nombreLigne,
      required this.nombreOffre,
      required this.monthlyRevenu,
      this.tm,
      this.bill,
      this.mom,
        this.lastVisiteDate,
          required this.allOffers,

        });

  factory ClientDetails.fromJson(Map<String, dynamic> json) {
    return ClientDetails(
      id: json['id'],
      raisonSociale: json['raison_sociale'] ?? "",
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      payerId: json['payer_id'] ?? "",
      payerName: json['payer_name'] ?? "",
      payerSize: json['payer_size'] ?? "",
      payerActivationDate: json['payer_activation_date'] ?? "",
      payerStatus: json['payer_status'] ?? "",
      payerCategory: json['payer_category'] ?? "",
      payerCollectorId: json['payer_collector_id'] ?? "",
      region: json['region'] ?? "",
      mainPackageFee: json['main_package_fee'],
      monthlyFee: json['monthly_fee'],
      speedFee: json['speed_fee'],
      dispatcherLicenseFee: json['dispatcher_license_fee'],
      dispatcherServiceFee: json['dispatcher_service_fee'],
      pptServiceFee: json['ppt_service_fee'],
      monthlyFeeGlobal: json['monthly_fee_global'],
      expiryDateTop1000: json['expiry_date_top1000'],
      saleId: json['sale_id'],
      status: json['status'] ?? "",
      nombreLigne: json['nombre_ligne'] ?? 0,
      nombreOffre: json['nombre_offre'] ?? 0,
      monthlyRevenu: double.tryParse(json["monthly_revenue"].toString()) ?? 0.0,
      tm: json['tm'],
      lastVisiteDate: json["last_visit"] != null ? json["last_visit"]["visit_date"] : null,
      mom: json["last_visit"] != null ? json["last_visit"]["text"] : null,
      bill: json["bill"] != null ? Bill.fromJson(json["bill"]) : null,
       allOffers: (json['all_offers'] as List<dynamic>? ?? [])
        .map((e) => Offer.fromJson(e))
        .toList(),
    );
  }
}

class Bill {
  final double countUnpaidBills;
  final double countPayedBills;
  final double unpaidAmount;
  final double lastBillAmount;
  final String? lastBillDate;

  Bill({
    required this.countUnpaidBills,
    required this.countPayedBills,
    required this.unpaidAmount,
    required this.lastBillAmount,
    this.lastBillDate,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      countUnpaidBills: (json["count-unpaid-bills"] ?? 0).toDouble(),
      countPayedBills: (json["count-payed-bills"] ?? 0).toDouble(),
      unpaidAmount: (json["unpaid-amount"] ?? 0).toDouble(),
      lastBillAmount: (json["last-bill-amount"] ?? 0).toDouble(),
      lastBillDate: json["last-bill-date"],
    );
  }
}
