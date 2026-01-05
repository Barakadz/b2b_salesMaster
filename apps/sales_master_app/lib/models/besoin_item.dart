import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BesoinItem {
  final String type;                 // type of besoin
  RxString details = ''.obs;         // reactive details
  TextEditingController controller;  // for the TextFormField

  // ✅ Constructor: define a named parameter 'details'
  BesoinItem({required this.type, String? details})
      : controller = TextEditingController(text: details ?? '') {
    if (details != null) {
      this.details.value = details;
    }
  }
}
class DeviceItem {
  final String type;
  RxString details = ''.obs;
  TextEditingController controller;

  // ✅ Constructor: define a named parameter 'details'
  DeviceItem({required this.type, String? details})
      : controller = TextEditingController(text: details ?? '') {
    if (details != null) {
      this.details.value = details;
    }
  }
}

