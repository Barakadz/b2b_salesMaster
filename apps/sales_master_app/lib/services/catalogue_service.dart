import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/file_model.dart';
import 'package:sales_master_app/models/roaming_model.dart';

class DocumentService {
  Future<CatalogueFile?> fetchServiceDocuments() async {
    try {
      final response = await Api.getInstance().get("document/service");

      if (response != null && response.data["success"] == true) {
        return CatalogueFile.fromJson(response.data["data"]);
      }
      return null;
    } catch (e, stackTrace) {
      print("Error fetching services document: $e\n $stackTrace");
      return null;
    }
  }

  Future<CatalogueFile?> fetchOffersDocument() async {
    try {
      final response = await Api.getInstance().get("document/offres");

      if (response != null && response.data["success"] == true) {
        final data = response.data["data"];
        return CatalogueFile.fromJson(data["offre"]);
      }
      return null;
    } catch (e) {
      print("Error fetching offers document: $e");
      return null;
    }
  }

  Future<CatalogueFile?> fetchBenchMarkDocument() async {
    try {
      final response = await Api.getInstance().get("document/offres");

      if (response != null && response.data["success"] == true) {
        final data = response.data["data"];
        return CatalogueFile.fromJson(data["benchmark"]);
      }
      return null;
    } catch (e) {
      print("Error fetching benchmark document: $e");
      return null;
    }
  }

  Future<TarifRoaming?> fetchTarifRoaming(int zoneId, String type) async {
    try {
      final response =
          await Api.getInstance().get("tarif-roaming/$zoneId/$type");

      if (response != null && response.data["success"] == true) {
        final data = response.data["data"];
        return TarifRoaming.fromJson(data);
      }
      return null;
    } catch (e) {
      print("Error fetching roaming tariff: $e");
      return null;
    }
  }
}
