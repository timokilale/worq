import 'package:attendance/api/user_enrollment_client.dart';
import 'package:attendance/contracts/user_enrollment_contract.dart';
import 'package:attendance/models/user_enrollment.dart';
import 'package:attendance/models/user_response.dart';
import 'package:get_it/get_it.dart';

final _locator = GetIt.I;

class UserEnrollmentRepository extends UserEnrollmentContract {
  @override
  Future<UserResponse> enroll(UserEnrollment enrollment) async {
    return await _locator<UserEnrollmentClient>()
        .enroll(enrollment)
        .then((response) => response);
  }
}
