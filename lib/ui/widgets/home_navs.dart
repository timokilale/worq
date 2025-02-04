import 'package:attendance/ui/widgets/common/custom_icon.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeNavs extends StatelessWidget {
  const HomeNavs({
    super.key,
    required this.navItem,
    required this.icon,
    required this.iconSize,
    required this.onMenuItemTap,
  });

  final String navItem;
  final String icon;
  final double iconSize;
  final VoidCallback onMenuItemTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMenuItemTap,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width / 6,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              width: 0.2,
              color: Colors.grey,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 1),
                blurRadius: 1.0,
                spreadRadius: 0,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 56,
                child: CustomIcon(
                  icon: icon,
                  size: iconSize,
                  paintIcon: true,
                  color: Color(int.parse(AppColors.primary)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Text(
                navItem,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
