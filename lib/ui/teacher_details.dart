import 'package:attendance/models/teacher.dart';
import 'package:attendance/ui/teachers.dart';
import 'package:attendance/ui/widgets/common/details_item.dart';
import 'package:attendance/ui/widgets/common/header.dart';
import 'package:attendance/ui/widgets/enrollment_dialog.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TeacherDetails extends StatefulWidget {
  const TeacherDetails({super.key, required this.teacher});

  final Teacher teacher;

  @override
  State<TeacherDetails> createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: 24.0),
              DetailsItem(
                label: 'REF ID',
                value: '${widget.teacher.teacherID}',
              ),
              DetailsItem(label: 'NAME', value: widget.teacher.name),
              DetailsItem(label: 'GENDER', value: widget.teacher.sex),
              DetailsItem(label: 'EMAIL', value: widget.teacher.email),
              const SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: MaterialButton(
                  color: Color(int.parse(AppColors.primary)),
                  minWidth: double.infinity,
                  height: 36.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          content: EnrollmentDialog(
                            prevScreen: const Teachers(),
                            userId: widget.teacher.teacherID,
                            userType: 'teacher',
                          ),
                        );
                      },
                    );
                  },
                  child: _enrollTxt(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _enrollTxt() => const Text(
        'Enroll',
        style: TextStyle(color: Colors.white),
      );
}
