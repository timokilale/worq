import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'academic_year.freezed.dart';

part 'academic_year.g.dart';

@freezed
@HiveType(typeId: 4)
class AcademicYear with _$AcademicYear {
  const factory AcademicYear({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
    @HiveField(2) @JsonKey(name: 'class_level_id') required int classLevelID,
  }) = _AcademicYear;

  factory AcademicYear.fromJson(Map<String, Object?> json) =>
      _$AcademicYearFromJson(json);
}
