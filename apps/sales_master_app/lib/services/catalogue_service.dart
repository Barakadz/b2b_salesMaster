import 'dart:convert';

import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/file_model.dart';
import 'package:sales_master_app/models/roaming_model.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class DocumentService {
  Future<void> downloadAndOpenFile(String fileName, int fileId) async {
    try {
      // Get the directory to save file
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';
      final token = AppStorage().getToken();
      
      // Dio setup
      final dio = Dio();
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/pdf', // adapt if needed
      };
      final api = Api.getInstance();
      final fullUrl = api.getFullUrl("document/${fileId}/download"); 
      
      // Download file
      print('⬇️ Downloading file...');
      final response = await dio.download(fullUrl, filePath);

      if (response.statusCode == 200) {
        print('File saved at: $filePath');
        
        // Open the downloaded file
        final result = await OpenFilex.open(filePath);
        print('Open result: ${result.message}');
      } else {
        print('Download failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  Future<void> downloadFile(String url, String fileName) async {
    try {
      // Get app directory
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';

      // Create dio instance
      final dio = Dio();

      // If your API requires authorization, include headers:
      dio.options.headers['Authorization'] = 'Bearer 17a3e373-5d99-3701-b5d2-3561d8c798ef';

      // Start download
      await dio.download(url, filePath);

      print('File downloaded to: $filePath');
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

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

  Future<List<CatalogueFile>> fetchOffersDocuments() async {
    try {
      final response = await Api.getInstance().get("document/offres");
  
      if (response != null) {
        final data = response.data["data"];
        
        print("########################################################################################");
        print("Offers Data: $data");
        print("########################################################################################");
        
        if (data["offre"] != null && data["offre"].isNotEmpty) {
          return (data["offre"] as List)
              .map((item) => CatalogueFile.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print("Error fetching offers documents: $e");
      return [];
    }
  }

  Future<List<CatalogueFile>> fetchBenchMarkDocuments() async {
    try {
      final response = await Api.getInstance().get("document/offres");
 
      if (response != null) {
        final data = response.data["data"];
        
        if (data["benchmark"] != null && data["benchmark"].isNotEmpty) {
          return (data["benchmark"] as List)
              .map((item) => CatalogueFile.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print("Error fetching benchmark documents: $e");
      return [];
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


   Future<List<TarifInternational>> fetchTarifInternational(String pays) async {
  try {
    final response = await Api.getInstance().get("tarif-international/$pays");

    if (response != null && response.data["success"] == true) {
      List data = response.data["data"];

      return data.map((e) => TarifInternational.fromJson(e)).toList();
    }

    return [];
  } catch (e) {
    print("Error fetching international tariff: $e");
    return [];
  }
}

}