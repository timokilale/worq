import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'dashboard_summary.freezed.dart';

part 'dashboard_summary.g.dart';

@freezed
@HiveType(typeId: 1)
class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    @HiveField(0) required String type,
    @HiveField(1) required int total,
    @HiveField(2) required int enrolled,
    @HiveField(3) required int pending,
  }) = _DashboardSummary;

  factory DashboardSummary.fromJson(Map<String, Object?> json) =>
      _$DashboardSummaryFromJson(json);
}
