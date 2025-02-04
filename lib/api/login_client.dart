import 'package:attendance/models/login.dart';
import 'package:attendance/models/login_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'login_client.g.dart';

@RestApi()
abstract class LoginClient {
  factory LoginClient(Dio dio, {String baseUrl}) = _LoginClient;

  @POST('/attendance')
  Future<LoginResponse> login(@Body() Login login);
}
