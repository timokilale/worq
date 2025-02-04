import 'package:attendance/ui/students.dart';
import 'package:attendance/ui/widgets/common/details_item.dart';
import 'package:attendance/ui/widgets/enrollment_dialog.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:attendance/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:attendance/models/student.dart';
import 'package:attendance/ui/widgets/common/header.dart';
import 'package:intl/intl.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key, required this.student});

  final Student student;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
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
                value: '${widget.student.studentId}',
              ),
              DetailsItem(label: 'NAME', value: widget.student.name),
              DetailsItem(label: 'GENDER', value: widget.student.sex),
              DetailsItem(label: 'CLASS', value: widget.student.className),
              DetailsItem(
                label: 'DATE CREATED',
                value: DateFormat.yMMMd()
                    .format(strToDate(widget.student.dateCreated)),
                hideDivider: true,
              ),
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
                            prevScreen: const Students(),
                            userId: widget.student.studentId,
                            userType: 'student',
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
