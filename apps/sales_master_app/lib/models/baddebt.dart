class BadDebt {
  String companyName;
  String numbers;
  int msisdnCount;
  int openBills;
  double lastBill;
  double globalDue;
  double globalDueAJ;

  BadDebt(
      {required this.companyName,
      required this.numbers,
      required this.msisdnCount,
      required this.openBills,
      required this.lastBill,
      required this.globalDue,
      required this.globalDueAJ});

  factory BadDebt.fromJson(Map<String, dynamic> json) {
    return BadDebt(
        companyName: json["company_name"],
        numbers: json["numbers"],
        msisdnCount: json["msisdn_count"],
        openBills: json["open_bills"],
        lastBill: json["last_bill"],
        globalDue: json["global_due"],
        globalDueAJ: json["global_due_aj"]);
  }
}
