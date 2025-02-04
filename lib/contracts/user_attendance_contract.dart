import 'package:attendance/models/user_attendance.dart';
import 'package:attendance/models/user_response.dart';

abstract class UserAttendanceContract {
  Future<UserResponse> registerAttendance(UserAttendance attendance);

  Future storeUserAttendance(UserAttendance attendance);

  Future<List<UserAttendance>?> getStoredUserAttendances();

  Future updateUserAttendance(UserAttendance attendance);

  Future deleteUserAttendance(bool synchronized);

  Future<void> clearUserAttendances();
}
