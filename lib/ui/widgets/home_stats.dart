import 'package:attendance/mappers/key_value_mappers.dart';
import 'package:attendance/models/dashboard_summary.dart';
import 'package:attendance/ui/widgets/common/custom_icon.dart';
import 'package:flutter/material.dart';

class HomeStats extends StatelessWidget {
  const HomeStats({super.key, required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          width: 56.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: navIconsBackground(summary.type),
          ),
          child: CustomIcon(
            icon: navIcons(summary.type),
            size: 20.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                summary.type,
                style: const TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey,
                ),
              ),
              Text(
                '${summary.total}',
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Visibility(
                visible: summary.enrolled > 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${summary.enrolled} ',
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.green,
                      ),
                    ),
                    const Text(
                      'Enrolled',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: summary.pending > 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${summary.pending} ',
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.red,
                      ),
                    ),
                    const Text(
                      'Pending',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
