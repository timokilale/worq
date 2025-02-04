import 'dart:async';

import 'package:attendance/models/student.dart';
import 'package:attendance/models/supporting_staff.dart';
import 'package:attendance/models/teacher.dart';
import 'package:attendance/models/user_attendance.dart';
import 'package:attendance/repositories/login_repository.dart';
import 'package:attendance/repositories/user_attendance_repository.dart';
import 'package:attendance/ui/widgets/common/custom_icon.dart';
import 'package:attendance/ui/widgets/common/header.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:attendance/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

final _locator = GetIt.I;

class FingerScanActive extends StatefulWidget {
  const FingerScanActive({super.key});

  @override
  State<FingerScanActive> createState() => _FingerScanActiveState();
}

class _FingerScanActiveState extends State<FingerScanActive> {
  String? _currentTime = '--:--:--';
  String? userType;
  String? result;
  int? scannedUserId;
  Student? student;
  Teacher? teacher;
  SupportingStaff? staff;
  String? scannedName;
  bool? showName;

  static const platformMethodChannel =
      MethodChannel('africa.shulesoft.attendance/device-sdk');

  _verifyFingerprint() async {
    String callResult;
    try {
      setState(() {
        result = null;
        showName = false;
      });
      _locator<Logger>().i("Invoking verifyFingerprint()");
      callResult =
          await platformMethodChannel.invokeMethod('verifyFingerprint');
      _locator<Logger>().i('callResult: $callResult');
      setState(() {
        result = callResult;
        showName = true;
      });
    } on PlatformException catch (e) {
      _locator<Logger>().e(e.message);
      setState(() {
        result = 'NOT_FOUND';
        showName = false;
      });
    }
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        showName = false;
      });
      _verifyFingerprint();
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateFormat.Hms().format(DateTime.now());
        if (result != null && result != 'NOT_FOUND') {
          userType = result!.split('_')[0];
          scannedUserId = int.parse(result!.split('_')[1]);
          switch (userType) {
            case 'student':
              student = _locator<LoginRepository>().getStudent(scannedUserId!);
              scannedName = student!.name;
            case 'teacher':
              teacher = _locator<LoginRepository>().getTeacher(scannedUserId!);
              scannedName = teacher!.name;
            case 'staff':
              staff = _locator<LoginRepository>().getStaff(scannedUserId!);
              scannedName = staff!.name;
          }
          createUserAttendance(scannedUserId.toString(), userType!);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Header(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$_currentTime',
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Visibility(
                visible:
                    result != null && result != 'NOT_FOUND' && showName == true,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 48.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        width: 1.0,
                        color: Color(int.parse(AppColors.primary)),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 1),
                          blurRadius: 1.0,
                          spreadRadius: 0,
                        )
                      ]),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('$scannedName'),
                      ],
                    ),
                  ),
                ),
              ),
              CustomIcon(
                icon: 'scan.png',
                size: MediaQuery.of(context).size.width / 3,
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void createUserAttendance(String userId, String userType) {
    UserAttendance attendance = UserAttendance(
      method: 'userAttendance',
      organizationId:
          _locator<LoginRepository>().getLoginResponse().organizationId,
      enrollmentOption: 'Fingerprint',
      checkInTime: datePattern(DateTime.now(), 'yyyy-MM-dd HH:mm:ss'),
      userId: userId,
      userType: userType,
      value: 'QUt24_ty2rxMTIz',
    );
    _locator<UserAttendanceRepository>().storeUserAttendance(attendance);
  }
}
