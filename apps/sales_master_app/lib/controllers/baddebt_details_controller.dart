import 'package:get/get.dart';
import 'package:sales_master_app/models/client.dart';
import 'package:sales_master_app/services/clients_service.dart';
import 'package:url_launcher/url_launcher.dart';

class BaddebtDetailsController extends GetxController {
  BaddebtDetailsController({required this.baddebt});

  final ClientListItem baddebt;

  Rx<bool> loadingDetails = false.obs;
  Rx<bool> errorLoadingDetails = false.obs;
  Rx<ClientDetails?> clientDetails = Rx<ClientDetails?>(null);

  @override
  void onInit() {
    super.onInit();
    getClientDetails();
  }

  Future<void> getClientDetails() async {
    loadingDetails.value = true;
    errorLoadingDetails.value = false;

    final ClientDetails? result =
        await ClientService().getClientById(baddebt.id);

    if (result != null) {
      clientDetails.value = result;
    } else {
      errorLoadingDetails.value = true;
      clientDetails.value = null;
    }
    loadingDetails.value = false;
  }

  Future<void> callNumber(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
