import 'package:attendance/utils/app_colors.dart';
import 'package:flutter/material.dart';

String? navIcons(String type) {
  print('navIcons called with type: $type'); // Debugging line
  Map<String, String> icons = {
    'student': 'student.png',
    'teachers': 'teacher.png',
    'staffs': 'staff.png',
  };
  return icons[type];
}


Color? navIconsBackground(String type) {
  Map<String, Color> colors = {
    'student': Color(int.parse(AppColors.lightGreen)),
    'teachers': Color(int.parse(AppColors.lightBlue)),
    'staffs': Color(int.parse(AppColors.lightRed)),
  };
  return colors[type];
}
