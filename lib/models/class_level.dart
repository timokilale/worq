import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'class_level.freezed.dart';

part 'class_level.g.dart';

@freezed
@HiveType(typeId: 2)
class ClassLevel with _$ClassLevel {
  const factory ClassLevel({
    @HiveField(0) @JsonKey(name: 'classlevel_id') required int ClassLevelID,
    @HiveField(1) required String name,
  }) = _ClassLevel;

  factory ClassLevel.fromJson(Map<String, Object?> json) =>
      _$ClassLevelFromJson(json);
}
