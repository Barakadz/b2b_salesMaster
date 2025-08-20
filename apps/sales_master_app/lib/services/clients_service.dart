import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/client.dart';

class ClientService {
  /// Fetch all clients (paginated)
  Future<PaginatedClientListItem?> getAllClients(
      {String? searchQuery, String? status}) async {
    try {
      Map<String, dynamic> queryParameters = {};

      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        queryParameters["search"] = searchQuery;
      }

      if (status != null && status.trim().isNotEmpty) {
        queryParameters["status"] = status;
      }

      final response = await Api.getInstance()
          .get("client", queryParameters: queryParameters);

      if (response != null && response.data?["success"] == true) {
        final data = response.data?["data"];
        return PaginatedClientListItem.fromJson({"data": data});
      }

      print("Failed to get clients: response was null or unsuccessful");
      return null;
    } catch (e, stacktrace) {
      print("Exception while fetching clients: $e\n$stacktrace");
      return null;
    }
  }

  /// Fetch one client by ID (full details)
  Future<ClientDetails?> getClientById(int id) async {
    try {
      final response = await Api.getInstance().get("client/$id");

      if (response != null && response.data?["success"] == true) {
        final data = response.data?["data"];
        return ClientDetails.fromJson(data);
      }

      print("Failed to get client details: response was null or unsuccessful");
      return null;
    } catch (e, stacktrace) {
      print("Exception while fetching client details: $e\n$stacktrace");
      return null;
    }
  }
}
