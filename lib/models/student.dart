import 'package:attendance/models/enrollment_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'student.freezed.dart';

part 'student.g.dart';

@freezed
@HiveType(typeId: 5)
class Student with _$Student {
  const factory Student({
    @HiveField(0) @JsonKey(name: 'student_id') required int studentId,
    @HiveField(1) required String name,
    @HiveField(2) required String dob,
    @HiveField(3) required String sex,
    @HiveField(4) required String roll,
    @HiveField(5) @JsonKey(name: 'class') required String className,
    @HiveField(6) @JsonKey(name: 'date_created') required String dateCreated,
    @HiveField(7) @JsonKey(name: 'class_id') required int classId,
    @HiveField(8) required String section,
    @HiveField(9) @JsonKey(name: 'section_id') required int sectionId,
    @HiveField(10) @JsonKey(name: 'academic_year') required String academicYear,
    @HiveField(11) @JsonKey(name: 'class_level') required String classLevel,
    @HiveField(12) @JsonKey(name: 'class_level_id') required int classLevelID,
    @HiveField(13)
    @JsonKey(name: 'enrollment_status')
    required String enrollmentStatus,
    @HiveField(14)
    @JsonKey(name: 'enrollemt_options')
    required List<EnrollmentOption> enrollmentOptions,
  }) = _Student;

  factory Student.fromJson(Map<String, Object?> json) =>
      _$StudentFromJson(json);
}
