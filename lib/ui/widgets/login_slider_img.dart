import 'package:flutter/cupertino.dart';

class LoginSliderImg extends StatelessWidget {
  const LoginSliderImg({super.key, required this.img});

  final String img;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: Image.asset(
        'assets/images/$img',
        fit: BoxFit.contain,
      ),
    );
  }
}
