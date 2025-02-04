import 'package:freezed_annotation/freezed_annotation.dart';

part 'login.freezed.dart';

part 'login.g.dart';

@freezed
class Login with _$Login {
  const factory Login({
    required String method,
    required int code,
    required String imei,
    required String latitude,
    required String longitude,
    required String agent,
  }) = _Login;

  factory Login.fromJson(Map<String, Object?> json) => _$LoginFromJson(json);
}
