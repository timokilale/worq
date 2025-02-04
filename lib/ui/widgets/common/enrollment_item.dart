import 'package:attendance/ui/widgets/common/custom_icon.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EnrollmentItem extends StatelessWidget {
  const EnrollmentItem({
    super.key,
    required this.item,
    required this.icon,
    required this.onEnrollmentItemTap,
  });

  final String item;
  final String icon;
  final VoidCallback onEnrollmentItemTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEnrollmentItemTap,
      child: Container(
        height: 96.0,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(int.parse(AppColors.primary)),
              ),
              child: CustomIcon(
                icon: icon,
                size: 32.0,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Color(int.parse(AppColors.primary)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
