import 'package:attendance/api/user_attendance_client.dart';
import 'package:attendance/contracts/user_attendance_contract.dart';
import 'package:attendance/database/drift/database.dart';
import 'package:attendance/models/user_attendance.dart';
import 'package:attendance/models/user_response.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';

final _locator = GetIt.I;
final _database = Database();

class UserAttendanceRepository extends UserAttendanceContract {
  @override
  Future<UserResponse> registerAttendance(UserAttendance attendance) async {
    return await _locator<UserAttendanceClient>()
        .registerAttendance(attendance)
        .then((response) => response);
  }

  @override
  Future storeUserAttendance(UserAttendance attendance) async {
    final data = UserAttendanceCompanion.insert(
      method: attendance.method,
      organizationId: attendance.organizationId,
      userId: attendance.userId,
      userType: attendance.userType,
      enrollmentOption: attendance.enrollmentOption,
      checkInTime: attendance.checkInTime,
      value: attendance.value,
      synchronized: attendance.synchronized!,
    );
    await _database.into(_database.userAttendance).insert(data);
  }

  @override
  Future<List<UserAttendance>?> getStoredUserAttendances() async {
    List<UserAttendanceData>? data =
        await _database.select(_database.userAttendance).get();
    List<UserAttendance> attendances = <UserAttendance>[];
    for (var attendance in data) {
      UserAttendance userAttendance = UserAttendance(
        method: attendance.method,
        organizationId: attendance.organizationId,
        userId: attendance.userId,
        userType: attendance.userType,
        enrollmentOption: attendance.enrollmentOption,
        checkInTime: attendance.checkInTime,
        value: attendance.value,
        synchronized: attendance.synchronized,
      );
      attendances.add(userAttendance);
    }
    return attendances;
  }

  @override
  Future updateUserAttendance(UserAttendance attendance) async {
    return await (_database.update(_database.userAttendance)
          ..where((a) => a.userId.equals(attendance.userId)))
        .write(const UserAttendanceCompanion(synchronized: Value(true)));
  }

  @override
  Future deleteUserAttendance(bool synchronized) async {
    await (_database.delete(_database.userAttendance)
          ..where((v) => v.synchronized.equals(synchronized)))
        .go();
  }

  @override
  Future<void> clearUserAttendances() async {
    await (_database.delete(_database.userAttendance)).go();
  }
}
