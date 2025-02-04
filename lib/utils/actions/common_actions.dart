import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final _locator = GetIt.I;

navigate(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

initFingerprintDevice(MethodChannel platformMethodChannel) async {
  try {
    _locator<Logger>().i("Invoking initFingerprintDevice()");
    platformMethodChannel.invokeMethod('initFingerprintDevice');
  } on PlatformException catch (e) {
    _locator<Logger>().e(e.message);
  }
}
