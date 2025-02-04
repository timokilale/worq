import 'package:attendance/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(int.parse(AppColors.tableHeaderLightGrey)),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          width: 0.2,
          color: Color(int.parse(AppColors.primary)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 2.0,
            spreadRadius: 1.0,
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 24.0),
          const SizedBox(width: 16.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              color: Color(int.parse(AppColors.primary)),
            ),
          ),
        ],
      ),
    );
  }
}
