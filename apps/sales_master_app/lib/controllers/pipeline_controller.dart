import 'package:get/get.dart';
import 'package:sales_master_app/models/pipeline_performance.dart';

class PipelineController extends GetxController {
  Rx<PipelinePerformance> myPipeLine = PipelinePerformance(
          id: -1,
          priseContact: 0,
          depotDoffre: 0,
          enCours: 0,
          conclusion: 0,
          globalValue: 0,
          raise: false,
          onHold: 0)
      .obs;
  RxBool loadingPipeline = true.obs;
  RxBool errorLoadingPipeline = false.obs;

  @override
  void onInit() {
    fetchPipeLine();
    super.onInit();
  }

  void fetchPipeLine() async {
    loadingPipeline.value = true;
    // errorLoadingPipeline.value = false;
    // PipelinePerformance? pipeLine = await PipelineService().getMyPipeline(1);
    // if (pipeLine == null) {
    //   errorLoadingPipeline.value = true;
    // } else {
    //   myPipeLine.value = pipeLine;
    // }
    // loadingPipeline.value = false;

    myPipeLine.value = PipelinePerformance(
        id: 1,
        globalValue: 30,
        raise: true,
        priseContact: 10,
        depotDoffre: 60,
        enCours: 20,
        conclusion: 5,
        onHold: 5);
    myPipeLine.refresh();
    loadingPipeline.value = false;
  }
}
