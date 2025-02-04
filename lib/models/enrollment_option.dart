import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'enrollment_option.freezed.dart';

part 'enrollment_option.g.dart';

@freezed
@HiveType(typeId: 6)
class EnrollmentOption with _$EnrollmentOption {
  const factory EnrollmentOption({
    @HiveField(0) @JsonKey(name: 'Barcode') required String barcode,
    @HiveField(1) @JsonKey(name: 'Face') required String face,
    @HiveField(2) @JsonKey(name: 'Fingerprint') required String fingerprint,
    @HiveField(3) @JsonKey(name: 'NFC') required String nfc,
  }) = _EnrollmentOption;

  factory EnrollmentOption.fromJson(Map<String, Object?> json) =>
      _$EnrollmentOptionFromJson(json);
}
