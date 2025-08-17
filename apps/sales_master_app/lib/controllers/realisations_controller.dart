import 'package:get/get.dart';
import 'package:sales_master_app/models/realisation.dart';
import 'package:sales_master_app/services/realisations_service.dart';

class RealisationsController extends GetxController {
  RxBool loadData = false.obs;
  RxBool showRealisation = true.obs;
  RxString selectedQuarter = "q2".obs;
  List<String> filter = ["q1", "q2", "q3", "q4"];

  //RxList<Realisation> realisations = <Realisation>[].obs;
  Rx<TotalRealisation?> totalRealisations = Rx<TotalRealisation?>(null);

  RxBool loadingRealisations = false.obs;
  RxBool errorLoadingRealisation = false.obs;

  String year = DateTime.now().year.toString();

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

  // @override
  // void onInit() {
  //   super.onInit();
  //   loadRealisation();
  // }

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
    double totalrealised = 0;

    totalrealised = (totalRealisations.value?.realisations ?? []).fold(
        totalrealised, (previous, element) => previous + element.currentValue);

    return totalrealised;
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
      }
    } catch (e) {
      errorLoadingRealisation.value = true;
    }

    totalRealisations.refresh();
    loadingRealisations.value = false;
  }
}
