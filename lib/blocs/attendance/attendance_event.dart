part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class RegisterAttendance extends AttendanceEvent {
  final UserAttendance attendance;

  const RegisterAttendance(this.attendance);

  @override
  List<Object> get props => [attendance];
}

class OnAttendanceError extends AttendanceEvent {}
