import 'package:data_layer/data_layer.dart'; // or your correct API import path
import 'package:sales_master_app/models/realisation.dart';

class RealisationService {
  Future<TotalRealisation?> fetchMyRealisations(String quarter) async {
    // String baseUrl = "https://apim.djezzy.dz/uat/djezzy-api/b2b/master/api/v1";
    //final testBaseUrl = "${baseUrl}/213770901100";
    //Api.getInstance().setBaseUrl(testBaseUrl);

    Map<String, dynamic> queryParameter = {"trimester": quarter};
    try {
      final response = await Api.getInstance()
          .get("realisation/my-realisation", queryParameters: queryParameter);
      //final testBaseUrl = "${baseUrl}/213784617787";
      //Api.getInstance().setBaseUrl(testBaseUrl);

      if (response != null &&
          (response.data["success"] == true ||
              response.data["suceess"] == true)) {
        final data = response.data["data"];
        return TotalRealisation.fromUnstructuredJson(data);
      }
    } catch (e) {
      //final testBaseUrl = "${baseUrl}/213784617787";
      //Api.getInstance().setBaseUrl(testBaseUrl);

      print("Error fetching realisations: $e");
    }

    return null;
  }
}
