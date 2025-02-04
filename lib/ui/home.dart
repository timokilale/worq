import 'package:attendance/models/dashboard_summary.dart';
import 'package:attendance/repositories/login_repository.dart';
import 'package:attendance/ui/finger_scan_active.dart';
import 'package:attendance/ui/settings.dart';
import 'package:attendance/ui/staffs.dart';
import 'package:attendance/ui/students.dart';
import 'package:attendance/ui/teachers.dart';
import 'package:attendance/ui/widgets/common/custom_icon.dart';
import 'package:attendance/ui/widgets/logo_cut.dart';
import 'package:attendance/ui/widgets/common/header.dart';
import 'package:attendance/ui/widgets/home_navs.dart';
import 'package:attendance/ui/widgets/home_stats.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final _locator = GetIt.I;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
              width: 88,
              height: 960,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 60,
                    color: const Color(0xFFE2ECF9).withOpacity(0.5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 120),
                    child: GestureDetector(
                      onTap: () => navigate(context, const Home()),
                      child: Container(
                        width: 42.0,
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(Icons.arrow_back, size: 30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: GestureDetector(
                      onTap: () => navigate(context, const Settings()),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(int.parse(AppColors.primary)),
                          ),
                        ),
                        child: Center(
                          child: Icon(Icons.settings, size: 30, color: Color(int.parse(AppColors.primary)),),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: GestureDetector(
                      onTap: () => navigate(context, const FingerScanActive()),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(int.parse(AppColors.primary)),
                          ),
                        ),
                        child: const Center(
                          child: CustomIcon(icon: 'qr.png', size: 30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                        width: 1352,
                        height: 54,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Header()
                          ],
                      ),
                    )
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 960,
                              height: 151,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 10),
                                    blurRadius: 60,
                                    color: const Color(0xFFE2ECF9).withOpacity(0.5),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      for (DashboardSummary summary in _locator<LoginRepository>().getLoginResponse().summary)
                                        Expanded(
                                          child: HomeStats(summary: summary),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 960,
                            height: 472,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 10),
                                  blurRadius: 60,
                                  color: const Color(0xFFE2ECF9).withOpacity(0.5),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 38, top: 2),
                                  child: Text(
                                    "Let's Enroll",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.01,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildEnrollCard(
                                      'Students',
                                      'student.png',
                                          () => navigate(context, const Students()),
                                    ),
                                    const SizedBox(width: 40),
                                    _buildEnrollCard(
                                      'Teachers',
                                      'teacher.png',
                                          () => navigate(context, const Teachers()),
                                    ),
                                    const SizedBox(width: 40),
                                    _buildEnrollCard(
                                      'Supporting Staff',
                                      'staff.png',
                                          () => navigate(context, const Staffs()),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnrollCard(String title, String icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 165,
        height: 171,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 12,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 3),
                    blurRadius: 12,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Center(
                child: CustomIcon(
                  icon: icon,
                  size: 31.2,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}