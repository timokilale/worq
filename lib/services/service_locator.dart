import 'package:attendance/api/common/dio_client.dart';
import 'package:attendance/api/login_client.dart';
import 'package:attendance/api/user_attendance_client.dart';
import 'package:attendance/api/user_enrollment_client.dart';
import 'package:attendance/repositories/login_repository.dart';
import 'package:attendance/repositories/user_attendance_repository.dart';
import 'package:attendance/repositories/user_enrollment_repository.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final _locator = GetIt.I;

void serviceLocatorInit() {
  String? baseUrl = "https://attendancedevice.shulesoft.africa/api";
  final dio = buildDioClient(baseUrl);
  _locator.registerLazySingleton<Logger>(() => Logger());
  _locator.registerLazySingleton<LoginClient>(() => LoginClient(dio));
  _locator.registerLazySingleton<UserEnrollmentClient>(
      () => UserEnrollmentClient(dio));
  _locator.registerLazySingleton<UserAttendanceClient>(
      () => UserAttendanceClient(dio));
  _locator.registerLazySingleton<LoginRepository>(() => LoginRepository());
  _locator.registerLazySingleton<UserEnrollmentRepository>(
      () => UserEnrollmentRepository());
  _locator.registerLazySingleton<UserAttendanceRepository>(
      () => UserAttendanceRepository());
}
