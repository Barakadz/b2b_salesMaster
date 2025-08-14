import 'package:get/get.dart';
import 'package:sales_master_app/models/baddebt.dart';
import 'package:url_launcher/url_launcher.dart';

class BaddebtDetailsController extends GetxController {
  BaddebtDetailsController({required this.baddebt});

  final BadDebt baddebt;

  Future<void> callNumber(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
