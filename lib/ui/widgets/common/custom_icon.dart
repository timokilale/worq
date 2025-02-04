import 'package:flutter/cupertino.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    this.icon,
    required this.size,
    this.paintIcon,
    this.color,
  });

  final String? icon;
  final double size;
  final bool? paintIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: Image.asset(
        'assets/icons/$icon',
        color: color,
        fit: BoxFit.contain,
      ),
    );
  }
}
