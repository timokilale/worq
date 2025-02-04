import 'package:attendance/models/academic_year.dart';
import 'package:attendance/models/class.dart';
import 'package:attendance/models/class_level.dart';
import 'package:attendance/models/dashboard_summary.dart';
import 'package:attendance/models/student.dart';
import 'package:attendance/models/supporting_staff.dart';
import 'package:attendance/models/teacher.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'login_response.freezed.dart';

part 'login_response.g.dart';

@freezed
@HiveType(typeId: 0)
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    @HiveField(0) required String organization,
    @HiveField(1) @JsonKey(name: 'organization_id') required int organizationId,
    @HiveField(2) required String logo,
    @HiveField(3)
    @JsonKey(name: 'summary')
    required List<DashboardSummary> summary,
    @HiveField(4)
    @JsonKey(name: 'classlevels')
    required List<ClassLevel> classLevels,
    @HiveField(5) @JsonKey(name: 'classes') required List<Class> classes,
    @HiveField(6)
    @JsonKey(name: 'academic_years')
    required List<AcademicYear> academicYears,
    @HiveField(7) required List<Student> students,
    @HiveField(8) required List<Teacher> teachers,
    @HiveField(9)
    @JsonKey(name: 'supporting_staffs')
    required List<SupportingStaff> supportingStaffs,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, Object?> json) =>
      _$LoginResponseFromJson(json);
}
