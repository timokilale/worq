import 'package:attendance/ui/home.dart';
import 'package:attendance/ui/widgets/logo_cut.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:flutter/cupertino.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 42.0,
              padding: const EdgeInsets.all(8.0),
              child: const LogoCut(),
            ),
            const Text(
              'ShuleSoft Secondary School',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
      ],
    );
  }
}
