import 'package:drift/drift.dart';

class UserAttendance extends Table {
  TextColumn get method => text()();

  IntColumn get organizationId => integer()();

  TextColumn get userId => text()();

  TextColumn get userType => text()();

  TextColumn get enrollmentOption => text()();

  TextColumn get checkInTime => text()();

  TextColumn get value => text()();

  BoolColumn get synchronized => boolean()();
}
