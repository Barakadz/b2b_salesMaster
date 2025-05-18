import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/client.dart';

class ClientsService {
  Future<List<Client>?> getAllClients() async {
    final response = await Api.getInstance().get("api/clients");
    if (response != null) {
      List<Client> clients = [];
      try {
        clients = response.data["clients"]
            .map<Client>((jsonObejct) => Client.fromJson(jsonObejct))
            .toList();
        return clients;
      } catch (e) {
        print("failed to parse clients ; $e");
        rethrow;
      }
    }
    return null;
  }
}
