import 'package:attendance/models/user_enrollment.dart';
import 'package:attendance/models/user_response.dart';

abstract class UserEnrollmentContract {
  Future<UserResponse> enroll(UserEnrollment enrollment);
}
