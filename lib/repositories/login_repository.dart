import 'package:attendance/api/login_client.dart';
import 'package:attendance/database/hive/db.dart';
import 'package:attendance/contracts/login_contract.dart';
import 'package:attendance/database/hive/storage_keys.dart';
import 'package:attendance/models/dashboard_summary.dart';
import 'package:attendance/models/login.dart';
import 'package:attendance/models/login_response.dart';
import 'package:attendance/models/student.dart';
import 'package:attendance/models/supporting_staff.dart';
import 'package:attendance/models/teacher.dart';
import 'package:get_it/get_it.dart';

final _locator = GetIt.I;

class LoginRepository extends LoginContract {
  @override
  Future<LoginResponse> doLogin(Login login) async {
    return await _locator<LoginClient>()
        .login(login)
        .then((response) => response);
  }

  @override
  storeLoginResponse(LoginResponse response) {
    getAttendanceBox().put(StorageKeys.loginResponse, response);
  }

  @override
  LoginResponse getLoginResponse() {
    return getAttendanceBox().get(StorageKeys.loginResponse);
  }

  @override
  Student getStudent(int studentId) {
    List<Student> filteredList = getLoginResponse()
        .students
        .where((student) => student.studentId == studentId)
        .toList();
    return filteredList[0];
  }

  @override
  Teacher getTeacher(int teacherId) {
    List<Teacher> filteredList = getLoginResponse()
        .teachers
        .where((teacher) => teacher.teacherID == teacherId)
        .toList();
    return filteredList[0];
  }

  @override
  SupportingStaff getStaff(int staffId) {
    List<SupportingStaff> filteredList = getLoginResponse()
        .supportingStaffs
        .where((staff) => staff.userID == staffId)
        .toList();
    return filteredList[0];
  }

  @override
  updateSummary(String userType) {
    List<DashboardSummary> summary = List.from(getLoginResponse().summary);
    List<DashboardSummary> filteredByItem =
        summary.where((summaryItem) => summaryItem.type == userType).toList();
    DashboardSummary dashboardSummary = filteredByItem[0];
    DashboardSummary updatedDashboardSummary = dashboardSummary.copyWith(
      enrolled: dashboardSummary.enrolled + 1,
      pending: dashboardSummary.pending - 1,
    );
    summary[summary.indexWhere((summaryItem) => summaryItem.type == userType)] =
        updatedDashboardSummary;
    LoginResponse response = getLoginResponse();
    LoginResponse updated = response.copyWith(summary: summary);
    storeLoginResponse(updated);
  }

  @override
  enrollStudent(int studentId) {
    List<Student> students = List.from(getLoginResponse().students);
    Student pending = getStudent(studentId);
    Student enrolled = pending.copyWith(enrollmentStatus: 'Enrolled');
    students[students.indexWhere((student) => student.studentId == studentId)] =
        enrolled;
    LoginResponse response = getLoginResponse();
    LoginResponse updated = response.copyWith(students: students);
    storeLoginResponse(updated);
  }

  @override
  enrollTeacher(int teacherId) {
    List<Teacher> teachers = List.from(getLoginResponse().teachers);
    Teacher pending = getTeacher(teacherId);
    Teacher enrolled = pending.copyWith(enrollmentStatus: 'Enrolled');
    teachers[teachers.indexWhere((teacher) => teacher.teacherID == teacherId)] =
        enrolled;
    LoginResponse response = getLoginResponse();
    LoginResponse updated = response.copyWith(teachers: teachers);
    storeLoginResponse(updated);
  }

  @override
  enrollStaff(int staffId) {
    List<SupportingStaff> staffs =
        List.from(getLoginResponse().supportingStaffs);
    SupportingStaff pending = getStaff(staffId);
    SupportingStaff enrolled = pending.copyWith(enrollmentStatus: 'Enrolled');
    staffs[staffs.indexWhere((staff) => staff.userID == staffId)] = enrolled;
    LoginResponse response = getLoginResponse();
    LoginResponse updated = response.copyWith(supportingStaffs: staffs);
    storeLoginResponse(updated);
  }
}
