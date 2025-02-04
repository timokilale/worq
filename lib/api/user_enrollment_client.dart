import 'package:attendance/models/user_enrollment.dart';
import 'package:attendance/models/user_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'user_enrollment_client.g.dart';

@RestApi()
abstract class UserEnrollmentClient {
  factory UserEnrollmentClient(Dio dio, {String baseUrl}) =
      _UserEnrollmentClient;

  @POST('/attendance')
  Future<UserResponse> enroll(@Body() UserEnrollment enrollment);
}
