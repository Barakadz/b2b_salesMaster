import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/models/realisation.dart';
import 'package:sales_master_app/services/realisations_service.dart';

class RealisationsController extends GetxController {
  RxBool loadData = false.obs;
  RxBool showRealisation = true.obs;
final RxString selectedQuarter = ''.obs;

void setQuarterFromDate() {
  final month = DateTime.now().month;

  if (month >= 1 && month <= 3) {
    selectedQuarter.value = 'Q1';
  } else if (month >= 4 && month <= 6) {
    selectedQuarter.value = 'Q2';
  } else if (month >= 7 && month <= 9) {
    selectedQuarter.value = 'Q3';
  } else {
    selectedQuarter.value = 'Q4';
  }
}
  List<String> filter = ["Q1", "Q2", "Q3", "Q4"];

  //RxList<Realisation> realisations = <Realisation>[].obs;
  Rx<TotalRealisation?> totalRealisations = Rx<TotalRealisation?>(null);

  RxBool loadingRealisations = false.obs;
  RxBool errorLoadingRealisation = false.obs;

  String year = "2025";

  //void toggleShowRealisation() {
  //  showRealisation.toggle();
  //  if (showRealisation.value == true) {
  //    //loadFakeRealisation();
  //    loadRealisation();
  //  } else {
  //    totalRealisations.value = null;
  //    totalRealisations.refresh();
  //  }
  //}

@override
void onInit() {
  super.onInit();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    setQuarterFromDate();
    loadRealisation();
  });
}



  // @override
  // void onReady() {
  //   super.onReady();
  //   loadRealisation();
  // }

  double getTotalTarget() {
    double totalTarget = 0;

    totalTarget = (totalRealisations.value?.realisations ?? [])
        .fold(totalTarget, (previous, element) => previous + element.target);

    return totalTarget;
  }

  // double getTotalRealisations() {
  //   double totalrealised = 0;

  //   totalrealised = (totalRealisations.value?.realisations ?? []).fold(
  //       totalrealised,
  //       (previous, element) => previous + element.percentage!.toInt());

  //   return totalrealised;
  // }

  double getTotalRealisations() {
    double ? totalrealised = 0;

    totalrealised =  totalRealisations.value?.increaseResult  ;

    return totalrealised ??0;
  }

  Future<void> loadFakeRealisation() async {
    loadingRealisations.value = true;
    errorLoadingRealisation.value = false;

    await Future.delayed(Duration(seconds: 3));
    totalRealisations.value = TotalRealisation(
        trimester: "Q3",
        year: "2025",
        assignedTo: 1,
        increase: 1.5,
        realisations: [
          Realisation(target: 100, currentValue: 20, name: "GA"),
          Realisation(target: 100, currentValue: 50, name: "Net Adds"),
          Realisation(target: 100, currentValue: 85, name: "Solutions"),
          Realisation(target: 100, currentValue: 15, name: "New Compte"),
          Realisation(target: 100, currentValue: 30, name: "Evaluation"),
        ]);
    totalRealisations.refresh();

    loadingRealisations.value = false;
    errorLoadingRealisation.value = false;
  }

  Future<void> loadRealisation() async {
    totalRealisations.value = null;
    loadingRealisations.value = true;
    errorLoadingRealisation.value = false;
    //totalRealisations.refresh();

    try {
      final TotalRealisation? result =
          await RealisationService().fetchMyRealisations(selectedQuarter.value);

      if (result != null) {
        totalRealisations.value = result;
      } else {
        errorLoadingRealisation.value = true;
        totalRealisations.value = TotalRealisation(
            increase: 0,
            realisations: [
              Realisation(target: 100, currentValue: 0, name: "GA"),
              Realisation(target: 100, currentValue: 0, name: "Net Adds"),
              Realisation(target: 100, currentValue: 0, name: "Solutions"),
              Realisation(target: 100, currentValue: 0, name: "New Compte"),
              Realisation(target: 100, currentValue: 0, name: "Evaluation"),
            ],
            trimester: "Q1",
            year: year,
            assignedTo: 0);
      }
    } catch (e) {
      errorLoadingRealisation.value = true;
    }

    totalRealisations.refresh();
    loadingRealisations.value = false;
  }
}
