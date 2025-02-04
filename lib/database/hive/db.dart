import 'package:attendance/database/hive/storage_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';

getAttendanceBox() => Hive.box(StorageKeys.attendanceBox);

getUserAttendanceBox() => Hive.box(StorageKeys.userAttendanceBox);
