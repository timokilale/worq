import 'package:attendance/ui/widgets/common/header.dart';
import 'package:attendance/ui/widgets/settings_item.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static const platformMethodChannel =
      MethodChannel('africa.shulesoft.attendance/device-sdk');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            GestureDetector(
              onTap: () => initFingerprintDevice(platformMethodChannel),
              child: const SettingsItem(
                icon: Icons.sync,
                title: 'Re-initialize fingerprint device',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
