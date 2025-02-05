import 'dart:async';

import 'package:attendance/blocs/bloc_exports.dart';
import 'package:attendance/models/user_enrollment.dart';
import 'package:attendance/repositories/login_repository.dart';
import 'package:attendance/ui/widgets/common/custom_icon.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final _locator = GetIt.I;

class FingerScanResult extends StatefulWidget {
  const FingerScanResult({
    super.key,
    required this.finger,
    required this.screen,
    required this.userId,
    required this.userType,
  });

  final Uint8List finger;
  final Widget screen;
  final int userId;
  final String userType;

  @override
  State<FingerScanResult> createState() => _FingerScanResultState();
}

class _FingerScanResultState extends State<FingerScanResult> {
  String textImg = 'scan_complete.png';

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        textImg = 'redirecting_back.png';
      });
      Future.delayed(const Duration(seconds: 1), () {
        switch (widget.userType) {
          case 'stundent':
            _locator<LoginRepository>().enrollStudent(widget.userId);
            _locator<LoginRepository>().updateSummary('stundent');
          case 'staff':
            _locator<LoginRepository>().enrollStaff(widget.userId);
            _locator<LoginRepository>().updateSummary('staffs');
          case 'teacher':
            _locator<LoginRepository>().enrollTeacher(widget.userId);
            _locator<LoginRepository>().updateSummary('teachers');
        }
        enrollUser(widget.userId, widget.userType);
        navigate(context, widget.screen);
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: widget.finger.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Image.memory(
                    widget.finger,
                    width: 72.0,
                    height: 72.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomIcon(
                    size: 40.0,
                    icon: 'check.png',
                  ),
                  const SizedBox(width: 8.0),
                  CustomIcon(
                    size: 168.0,
                    icon: textImg,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void enrollUser(int userId, String userType) {
    UserEnrollment enrollment = UserEnrollment(
      method: 'enrollUser',
      userId: userId,
      userType: userType,
      organizationId:
          _locator<LoginRepository>().getLoginResponse().organizationId,
      enrollmentOption: 'Fingerprint',
      value: 'QUt24_ty2rxMTIz',
    );
    BlocProvider.of<EnrollmentBloc>(context).add(Enroll(enrollment));
  }
}
