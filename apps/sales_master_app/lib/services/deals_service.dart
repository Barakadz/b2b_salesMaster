import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/deal.dart';

class DealsService {
  
  Future<PaginatedDeals?> getAllDeals({
      String? searchQuery, String? status,int page = 1}) async {
    try {
Map<String, dynamic> queryParameters = {"page": page};

      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        queryParameters["search"] = searchQuery;
      }

      if (status != null) {
        queryParameters["status"] = status;
      } 

      final response = await Api.getInstance()
          .get("deal/my-deals", queryParameters: queryParameters);
print("*****************************************************************");
      if (response != null && response.data?["success"] == true) {
        final data = response.data?["data"];
        print("${data}");
        return PaginatedDeals.fromJson(data);
      }

      print("Failed to get deals: response was null or unsuccessful");
      return null;
    } catch (e, stacktrace) {
      print("Exception while fetching deals: $e\n$stacktrace");
      return null;
    }
  }

  Future<bool> createDeal(Map<String, dynamic> data) async {
    try {
      print("###############################################################");
      print("###############################################################");
      print("###############################################################");
      print("###############################################################");
      print("###############################################################");
      print("###############################################################");
      print("###############################################################");
      print("###############################################################");
      print("###############################################################");
      print("###############################################################");
      print("###############################################################");
      print("${data}");
      final response = await Api.getInstance().post("deal/", data: data);
      return response != null && response.data["success"] == true;
    } catch (e) {
      print("Failed to create deal: $e");
      return false;
    }
  }

  Future<bool> updateDeal(int id, Map<String, dynamic> data) async {
    try {
      final response =
          await Api.getInstance().post("deal/$id/update", data: data);
      return response != null && response.data["success"] == true;
    } catch (e) {
      print("Failed to update deal: $e");
      return false;
    }
  }
}
