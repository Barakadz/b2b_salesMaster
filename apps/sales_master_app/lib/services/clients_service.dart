import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/client.dart';

class ClientService {
  Future<PaginatedClient?> getAllClients({
    String? searchQuery,
    int? page,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {};

      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        queryParameters["search"] = searchQuery;
      }

      if (page != null) {
        queryParameters["page"] = page.toString();
      }

      final response = await Api.getInstance()
          .get("client", queryParameters: queryParameters);

      if (response != null && response.data?["success"] == true) {
        final data = response.data?["data"];
        return PaginatedClient.fromJson(data);
      }

      print("Failed to get clients: response was null or unsuccessful");
      return null;
    } catch (e, stacktrace) {
      print("Exception while fetching clients: $e\n$stacktrace");
      return null;
    }
  }

  Future<bool> createClient(Map<String, dynamic> data) async {
    try {
      final response = await Api.getInstance().post("client", data: data);
      return response != null && response.data["success"] == true;
    } catch (e) {
      print("Failed to create client: $e");
      return false;
    }
  }

  Future<bool> updateClient(int id, Map<String, dynamic> data) async {
    try {
      final response =
          await Api.getInstance().post("client/$id/update", data: data);
      return response != null && response.data["success"] == true;
    } catch (e) {
      print("Failed to update client: $e");
      return false;
    }
  }
}
