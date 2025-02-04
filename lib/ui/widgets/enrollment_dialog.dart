import 'package:attendance/ui/finger_scanner.dart';
import 'package:attendance/ui/widgets/common/enrollment_item.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:flutter/cupertino.dart';

class EnrollmentDialog extends StatefulWidget {
  const EnrollmentDialog({
    super.key,
    required this.prevScreen,
    required this.userId,
    required this.userType,
  });

  final Widget prevScreen;
  final int userId;
  final String userType;

  @override
  State<EnrollmentDialog> createState() => _EnrollmentDialogState();
}

class _EnrollmentDialogState extends State<EnrollmentDialog> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EnrollmentItem(
          item: 'QR',
          icon: 'qr.png',
          onEnrollmentItemTap: () => navigate(
            context,
            FingerScanner(
              scanType: 'Scan QR Code',
              icon: 'scan_qr.png',
              description: 'Scan QR code here',
              prevScreen: widget.prevScreen,
              userId: widget.userId,
              userType: widget.userType,
            ),
          ),
        ),
        EnrollmentItem(
          item: 'BARCODE',
          icon: 'barcode.png',
          onEnrollmentItemTap: () => navigate(
            context,
            FingerScanner(
              scanType: 'Scan Barcode',
              icon: 'scan_barcode.png',
              description: 'Scan barcode here',
              prevScreen: widget.prevScreen,
              userId: widget.userId,
              userType: widget.userType,
            ),
          ),
        ),
        EnrollmentItem(
          item: 'NFC',
          icon: 'nfc.png',
          onEnrollmentItemTap: () => navigate(
            context,
            FingerScanner(
              scanType: 'Scan NFC',
              icon: 'scan_nfc.png',
              description: 'Scan NFC here',
              prevScreen: widget.prevScreen,
              userId: widget.userId,
              userType: widget.userType,
            ),
          ),
        ),
        EnrollmentItem(
          item: 'FINGERPRINT',
          icon: 'fingerprint.png',
          onEnrollmentItemTap: () {
            navigate(
              context,
              FingerScanner(
                scanType: 'Scan Fingerprint',
                icon: 'scan_fingerprint.png',
                description: 'Scan fingerprint here',
                prevScreen: widget.prevScreen,
                userId: widget.userId,
                userType: widget.userType,
              ),
            );
          },
        ),
        EnrollmentItem(
          item: 'FACE ID',
          icon: 'face.png',
          onEnrollmentItemTap: () => navigate(
            context,
            FingerScanner(
              scanType: 'Scan Face',
              icon: 'scan_face.png',
              description: 'Scan your face here',
              prevScreen: widget.prevScreen,
              userId: widget.userId,
              userType: widget.userType,
            ),
          ),
        ),
      ],
    );
  }
}
