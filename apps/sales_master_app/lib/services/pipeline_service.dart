import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/pipeline_performance.dart';

class PipelineService {
  Future<PipelinePerformance?> getMyPipeline(int userId) async {
    final response = await Api.getInstance().get("api/pipeLine/$userId");
    if (response != null) {
      try {
        PipelinePerformance pipelineService =
            PipelinePerformance.fromJson(response.data);
        return pipelineService;
      } catch (e) {
        print("failed to parse / fetch pipeLine : $e");
        rethrow;
      }
    }
    return null;
  }
}
