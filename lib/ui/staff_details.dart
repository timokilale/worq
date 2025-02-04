import 'package:attendance/models/supporting_staff.dart';
import 'package:attendance/ui/staffs.dart';
import 'package:attendance/ui/widgets/common/details_item.dart';
import 'package:attendance/ui/widgets/common/header.dart';
import 'package:attendance/ui/widgets/enrollment_dialog.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:flutter/material.dart';

class StaffDetails extends StatefulWidget {
  const StaffDetails({super.key, required this.staff});

  final SupportingStaff staff;

  @override
  State<StaffDetails> createState() => _StaffDetailsState();
}

class _StaffDetailsState extends State<StaffDetails> {
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
                value: '${widget.staff.userID}',
              ),
              DetailsItem(label: 'NAME', value: widget.staff.name),
              DetailsItem(label: 'GENDER', value: widget.staff.sex),
              DetailsItem(label: 'EMAIL', value: widget.staff.email),
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
                            prevScreen: const Staffs(),
                            userId: widget.staff.userID,
                            userType: 'staff',
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
