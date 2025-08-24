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

  Future<bool> updateTm(int clientId, String email) async {
    try {
      final body = {"email": email};

      final response = await Api.getInstance()
          .post("client/$clientId/update-tm", data: body);

      if (response != null && response.data?["success"] == true) {
        return true;
      }

      print("Failed to update TM: response was null or unsuccessful");
      return false;
    } catch (e, stacktrace) {
      print("Exception while updating TM: $e\n$stacktrace");
      return false;
    }
  }

  Future<bool> addMom(int clientId, String mom) async {
    try {
      final body = {
        "mom": mom,
        "visit_date": DateTime.now().toString().substring(0, 19),
      };

      final response =
          await Api.getInstance().post("client/$clientId/add-mom", data: body);

      if (response != null && response.data?["success"] == true) {
        return true;
      }

      print("Failed to add MOM: response was null or unsuccessful");
      return false;
    } catch (e, stacktrace) {
      print("Exception while adding MOM: $e\n$stacktrace");
      return false;
    }
  }
}
