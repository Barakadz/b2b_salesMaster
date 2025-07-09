import 'package:data_layer/data_layer.dart';
import 'package:sales_master_app/models/pipeline_performance.dart';
import 'package:intl/intl.dart';

// class PipelineService {
//   Future<PipelinePerformance?> getMyPipeline(int userId) async {
//     final response = await Api.getInstance().get("api/pipeLine/$userId");
//     if (response != null) {
//       try {
//         PipelinePerformance pipelineService =
//             PipelinePerformance.fromJson(response.data);
//         return pipelineService;
//       } catch (e) {
//         print("failed to parse / fetch pipeLine : $e");
//         rethrow;
//       }
//     }
//     return null;
//   }
// }

class PipelineService {
  Future<PipelinePerformance?> fetchMyPerformance({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final now = DateTime.now();
      final DateTime end = endDate ?? now;
      final DateTime start =
          startDate ?? DateTime(now.year, now.month - 1, now.day);

      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formattedStart = formatter.format(start);
      final String formattedEnd = formatter.format(end);

      final response = await Api.getInstance().get(
        "/deal/performance",
        queryParameters: {
          'start_date': formattedStart,
          'end_date': formattedEnd,
        },
      );

      if (response != null && response.data != null) {
        return PipelinePerformance.fromJson(response.data['data']);
      }
    } catch (e) {
      print("Error fetching pipeline performance: $e");
    }
    return null;
  }
}
