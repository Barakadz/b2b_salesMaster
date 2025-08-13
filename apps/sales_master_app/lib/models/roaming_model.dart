class TarifRoaming {
  int zone;
  String type;
  int localCall;
  int callToAlgeria;
  int internationalCall;
  int receiveCall;
  int sms;
  int dataB2B;
  int dataB2C;

  TarifRoaming({
    required this.zone,
    required this.type,
    required this.localCall,
    required this.callToAlgeria,
    required this.internationalCall,
    required this.receiveCall,
    required this.sms,
    required this.dataB2B,
    required this.dataB2C,
  });

  factory TarifRoaming.fromJson(Map<String, dynamic> json) {
    return TarifRoaming(
      zone: json["zone"],
      type: json["type"],
      localCall: json["local_call"],
      callToAlgeria: json["call_to_algeria"],
      internationalCall: json["international_call"],
      receiveCall: json["receive_call"],
      sms: json["sms"],
      dataB2B: json["data_b2b"],
      dataB2C: json["data_b2c"],
    );
  }
}
