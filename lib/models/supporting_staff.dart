import 'package:attendance/models/enrollment_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'supporting_staff.freezed.dart';

part 'supporting_staff.g.dart';

@freezed
@HiveType(typeId: 8)
class SupportingStaff with _$SupportingStaff {
  const factory SupportingStaff({
    @HiveField(0) @JsonKey(name: 'user_id') required int userID,
    @HiveField(1) required String name,
    @HiveField(2) required String dob,
    @HiveField(3) required String sex,
    @HiveField(4) required String email,
    @HiveField(5)
    @JsonKey(name: 'enrollment_status')
    required String enrollmentStatus,
    @HiveField(6)
    @JsonKey(name: 'enrollemt_options')
    required List<EnrollmentOption> enrollmentOptions,
  }) = _SupportingStaff;

  factory SupportingStaff.fromJson(Map<String, Object?> json) =>
      _$SupportingStaffFromJson(json);
}
