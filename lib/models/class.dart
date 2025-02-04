import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'class.freezed.dart';

part 'class.g.dart';

@freezed
@HiveType(typeId: 3)
class Class with _$Class {
  const factory Class({
    @HiveField(0) @JsonKey(name: 'classesID') required int classID,
    @HiveField(1) @JsonKey(name: 'classes') required String classes,
    @HiveField(2) @JsonKey(name: 'classlevel_id') required int classLevelID,
  }) = _Class;

  factory Class.fromJson(Map<String, Object?> json) => _$ClassFromJson(json);
}
