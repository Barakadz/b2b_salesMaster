class ClientListItem {
  int id;
  String name;
  bool isTopClient;
  bool isActive;
  String msisdnCount;

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
  final int monthlyRevenu;
  final dynamic tm;
  final dynamic bill;

  ClientDetails({
    required this.id,
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
      monthlyRevenu: json['monthly_revenu'] ?? 0,
      tm: json['tm'],
      bill: json['bill'],
    );
  }
}
