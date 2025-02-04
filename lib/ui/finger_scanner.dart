import 'package:attendance/ui/finger_scan_result.dart';
import 'package:attendance/ui/widgets/common/custom_icon.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final _locator = GetIt.I;

class FingerScanner extends StatefulWidget {
  const FingerScanner({
    super.key,
    required this.scanType,
    required this.icon,
    required this.description,
    required this.prevScreen,
    required this.userId,
    required this.userType,
  });

  final String scanType;
  final String icon;
  final String description;
  final Widget prevScreen;
  final int userId;
  final String userType;

  @override
  State<FingerScanner> createState() => _FingerScannerState();
}

class _FingerScannerState extends State<FingerScanner> {
  Uint8List finger = Uint8List(0);
  static const platformMethodChannel =
      MethodChannel('africa.shulesoft.attendance/device-sdk');

  Future<Uint8List> _captureFingerprint() async {
    Uint8List fingerImage;
    try {
      _locator<Logger>().i("Invoking enrollFingerprint()");
      fingerImage = await platformMethodChannel.invokeMethod(
          'enrollFingerprint',
          {'userId': '${widget.userType}_${widget.userId}'});
      setState(() {
        finger = fingerImage;
      });
    } on PlatformException catch (e) {
      _locator<Logger>().e(e.message);
      fingerImage = Uint8List(0);
    }
    return fingerImage;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      Uint8List capturedBitmap = await _captureFingerprint();
      if (capturedBitmap.isNotEmpty) {
        navigate(
          context,
          FingerScanResult(
            finger: capturedBitmap,
            screen: widget.prevScreen,
            userId: widget.userId,
            userType: widget.userType,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.scanType,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomIcon(
                icon: widget.icon,
                size: MediaQuery.of(context).size.width / 3,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(widget.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
