import 'package:get/get.dart';
import 'package:sales_master_app/models/pipeline_performance.dart';
import 'package:sales_master_app/services/pipeline_service.dart';

class PipelineController extends GetxController {
  Rx<PipelinePerformance?> myPipeLine = Rx<PipelinePerformance?>(null);
  RxBool loadingPipeline = true.obs;
  RxBool errorLoadingPipeline = false.obs;

  final PipelinePerformance emptyPipelinePerformance = PipelinePerformance(
    performance: 0,
    currentMonth: 0,
    previousMonth: 0,
    stats: [
      PipelineStat(status: 'Prise de contact', count: 0, percentage: 0),
      PipelineStat(status: "Depot d'offre", count: 0, percentage: 0),
      PipelineStat(status: 'En cours', count: 0, percentage: 0),
      PipelineStat(status: 'Conclusion', count: 0, percentage: 0),
      PipelineStat(status: 'On hold', count: 0, percentage: 0),
    ],
  );

  @override
  void onInit() {
    fetchFakePipeline();
    super.onInit();
  }

  void fetchFakePipeline() async {
    myPipeLine.value = emptyPipelinePerformance;
    loadingPipeline.value = true;
    errorLoadingPipeline.value = false;

    try {
      await Future.delayed(Duration(seconds: 2));
      final data = {
        "message": "",
        "data": {
          "stats": [
            {"status": "Prise de contact", "count": 12, "percentage": 50},
            {"status": "Depot d'offre", "count": 19, "percentage": 70},
            {"status": "En cours", "count": 16, "percentage": 60},
            {"status": "Conclusion", "count": 24, "percentage": 90},
            {"status": "On hold", "count": 9, "percentage": 30}
          ],
          "performance": 30,
          "current_month": 70,
          "previous_month": 40
        }
      };

      myPipeLine.value = PipelinePerformance.fromJson(data);
    } catch (e) {
      errorLoadingPipeline.value = true;
    }

    loadingPipeline.value = false;
    loadingPipeline.refresh();
  }

  void fetchPipeLine() async {
    loadingPipeline.value = true;
    errorLoadingPipeline.value = false;

    final result = await PipelineService().fetchMyPerformance();

    if (result == null) {
      errorLoadingPipeline.value = true;
    } else {
      myPipeLine.value = result;
    }

    loadingPipeline.value = false;
  }
}
