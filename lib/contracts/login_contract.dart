import 'package:attendance/models/login.dart';
import 'package:attendance/models/login_response.dart';
import 'package:attendance/models/student.dart';
import 'package:attendance/models/supporting_staff.dart';
import 'package:attendance/models/teacher.dart';

abstract class LoginContract {
  Future<LoginResponse> doLogin(Login login);

  storeLoginResponse(LoginResponse response);

  LoginResponse getLoginResponse();

  Student getStudent(int studentId);

  SupportingStaff getStaff(int staffId);

  Teacher getTeacher(int teacherId);

  enrollStudent(int studentId);

  enrollTeacher(int teacherId);

  enrollStaff(int staffId);

  updateSummary(String userType);
}
