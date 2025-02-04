import 'package:flutter/material.dart';

class DetailsItem extends StatelessWidget {
  const DetailsItem({
    super.key,
    required this.label,
    required this.value,
    this.hideDivider,
  });

  final String label;
  final String value;
  final bool? hideDivider;

  @override
  Widget build(BuildContext context) {
    bool? drawDivider = hideDivider == null ? true : false;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerRight,
              child: Text(
                '$label:',
                style: const TextStyle(fontSize: 12.0),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: drawDivider == true,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(
              thickness: 0.2,
              color: Colors.grey,
              height: 4.0,
            ),
          ),
        ),
      ],
    );
  }
}
