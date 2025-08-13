import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/coutry_model.dart';

class CountryService {
  Future<List<Country>> fetchCountries() async {
    try {
      final response = await Api.getInstance().get("countries");

      if (response != null && response.data["success"] == true) {
        final data = response.data["data"] as List;
        return data.map((e) => Country.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print("Error fetching countries: $e");
      return [];
    }
  }
}
