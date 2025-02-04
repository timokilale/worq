import 'package:flutter/cupertino.dart';

class LogoCut extends StatelessWidget {
  const LogoCut({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_cut.png',
      fit: BoxFit.contain,
    );
  }
}
