import 'package:attendance/ui/widgets/logo.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: const Logo(),
        ),
      ),
    );
  }
}
