import 'package:attendance/models/user_attendance.dart';
import 'package:attendance/models/user_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'user_attendance_client.g.dart';

@RestApi()
abstract class UserAttendanceClient {
  factory UserAttendanceClient(Dio dio, {String baseUrl}) =
      _UserAttendanceClient;

  @POST('/attendance')
  Future<UserResponse> registerAttendance(@Body() UserAttendance attendance);
}
