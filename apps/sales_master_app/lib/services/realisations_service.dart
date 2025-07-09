import 'package:data_layer/data_layer.dart'; // or your correct API import path
import 'package:sales_master_app/models/realisation.dart';

class RealisationService {
  Future<TotalRealisation?> fetchMyRealisations() async {
    try {
      final response =
          await Api.getInstance().get("realisation/my-realisation");

      if (response != null && response.data["success"] == true) {
        final data = response.data["data"];
        return TotalRealisation.fromUnstructuredJson(data);
      }
    } catch (e) {
      print("Error fetching realisations: $e");
    }

    return null;
  }
}
