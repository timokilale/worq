import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_enrollment.freezed.dart';

part 'user_enrollment.g.dart';

@freezed
class UserEnrollment with _$UserEnrollment {
  const factory UserEnrollment({
    required String method,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_type') required String userType,
    @JsonKey(name: 'organization_id') required int organizationId,
    @JsonKey(name: 'enrollment_option') required String enrollmentOption,
    @JsonKey(name: 'value') required String value,
  }) = _UserEnrollment;

  factory UserEnrollment.fromJson(Map<String, Object?> json) =>
      _$UserEnrollmentFromJson(json);
}
