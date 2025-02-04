import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_attendance.freezed.dart';

part 'user_attendance.g.dart';

@freezed
class UserAttendance with _$UserAttendance {
  const factory UserAttendance({
    required String method,
    @JsonKey(name: 'organization_id') required int organizationId,
    @JsonKey(name: 'enrollment_option') required String enrollmentOption,
    @JsonKey(name: 'checkin_time') required String checkInTime,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_type') required String userType,
    @JsonKey(name: 'value') required String value,
    @JsonKey(name: 'synchronized') bool? synchronized,
  }) = _UserAttendance;

  factory UserAttendance.fromJson(Map<String, Object?> json) =>
      _$UserAttendanceFromJson(json);
}
