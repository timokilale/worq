import 'dart:async';

import 'package:attendance/models/student.dart';
import 'package:attendance/models/supporting_staff.dart';
import 'package:attendance/models/teacher.dart';
import 'package:attendance/repositories/login_repository.dart';
import 'package:attendance/ui/finger_scan_active.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final _locator = GetIt.I;

class ScanActiveResult extends StatefulWidget {
  const ScanActiveResult({super.key, required this.userId});

  final String userId;

  @override
  State<ScanActiveResult> createState() => _ScanActiveResultState();
}

class _ScanActiveResultState extends State<ScanActiveResult> {
  String? userType;
  int? scannedUserId;
  Student? student;
  Teacher? teacher;
  SupportingStaff? staff;
  String? scannedName;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (widget.userId == 'NOT_FOUND') {
        setState(() {
          userType = 'NOT_FOUND';
        });
      } else {
        userType = widget.userId.split('_')[0];
        scannedUserId = int.parse(widget.userId.split('_')[1]);
        switch (userType) {
          case 'student':
            student = _locator<LoginRepository>().getStudent(scannedUserId!);
            setState(() {
              scannedName = student!.name;
            });
          case 'teacher':
            teacher = _locator<LoginRepository>().getTeacher(scannedUserId!);
            setState(() {
              scannedName = teacher!.name;
            });
          case 'staff':
            staff = _locator<LoginRepository>().getStaff(scannedUserId!);
            setState(() {
              scannedName = staff!.name;
            });
        }
      }
      Future.delayed(const Duration(seconds: 1), () {
        navigate(context, const FingerScanActive());
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
          child: Visibility(
            visible: userType != null,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    width: 1.0,
                    color: userType == 'NOT_FOUND'
                        ? Colors.red
                        : Color(int.parse(AppColors.primary)),
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
                    Text(
                        userType == 'NOT_FOUND' ? 'NOT FOUND' : '$scannedName'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
