import 'package:attendance/models/user_attendance.dart';
import 'package:attendance/models/user_response.dart';
import 'package:attendance/repositories/user_attendance_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

final _locator = GetIt.I;

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceInitial()) {
    on<RegisterAttendance>((event, emit) async {
      try {
        emit(AttendanceLoading());
        UserResponse response = await _locator<UserAttendanceRepository>()
            .registerAttendance(event.attendance);
        emit(AttendanceLoaded(response));
      } on OnAttendanceError {
        emit(const AttendanceError('An error has occurred'));
      }
    });
  }
}
