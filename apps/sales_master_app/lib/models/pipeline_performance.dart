class PipelineStat {
  final String status;
  final int count;
  final double percentage;

  PipelineStat({
    required this.status,
    required this.count,
    required this.percentage,
  });

  factory PipelineStat.fromJson(Map<String, dynamic> json) {
    return PipelineStat(
      status: json['status'],
      count: json['count'],
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }
}

class PipelinePerformance {
  final List<PipelineStat> stats;
  final double performance;
  final double currentMonth;
  final double previousMonth;

  PipelinePerformance({
    required this.stats,
    required this.performance,
    required this.currentMonth,
    required this.previousMonth,
  });

  factory PipelinePerformance.fromJson(Map<String, dynamic> json) {
    final data = json["data"] ?? {};
    return PipelinePerformance(
      stats: (data['stats'] as List<dynamic>)
          .map((e) => PipelineStat.fromJson(e))
          .toList(),
      performance: (data['performance'] ?? 0).toDouble(),
      currentMonth: (data['current_month'] ?? 0).toDouble(),
      previousMonth: (data['previous_month'] ?? 0).toDouble(),
    );
  }
}
