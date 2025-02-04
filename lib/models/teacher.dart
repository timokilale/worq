import 'package:attendance/models/enrollment_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'teacher.freezed.dart';

part 'teacher.g.dart';

@freezed
@HiveType(typeId: 7)
class Teacher with _$Teacher {
  const factory Teacher({
    @HiveField(0) @JsonKey(name: 'teacher_id') required int teacherID,
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
  }) = _Teacher;

  factory Teacher.fromJson(Map<String, Object?> json) =>
      _$TeacherFromJson(json);
}
