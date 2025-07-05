import 'package:get/get.dart';
import 'package:sales_master_app/models/realisation.dart';

class RealisationsController extends GetxController {
  RxBool loadData = false.obs;
  RxBool showRealisation = false.obs;

  //RxList<Realisation> realisations = <Realisation>[].obs;
  Rx<TotalRealisation?> totalRealisations = Rx<TotalRealisation?>(null);

  RxBool loadingRealisations = false.obs;
  RxBool errorLoadingRealisation = false.obs;

  void toggleShowRealisation() {
    showRealisation.toggle();
    if (showRealisation.value == true) {
      loadFakeRealisation();
    } else {
      totalRealisations.value = null;
      totalRealisations.refresh();
    }
  }

  double getTotalTarget() {
    double totalTarget = 0;

    totalTarget = (totalRealisations.value?.realisations ?? [])
        .fold(totalTarget, (previous, element) => previous + element.target);

    return totalTarget;
  }

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
    totalRealisations.value = TotalRealisation(increase: 1.5, realisations: [
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
}
