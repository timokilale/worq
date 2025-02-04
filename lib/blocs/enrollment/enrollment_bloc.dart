import 'package:attendance/models/user_enrollment.dart';
import 'package:attendance/models/user_response.dart';
import 'package:attendance/repositories/user_enrollment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'enrollment_event.dart';

part 'enrollment_state.dart';

final _locator = GetIt.I;

class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
  EnrollmentBloc() : super(EnrollmentInitial()) {
    on<Enroll>((event, emit) async {
      try {
        emit(EnrollmentLoading());
        UserResponse response =
            await _locator<UserEnrollmentRepository>().enroll(event.enrollment);
        emit(EnrollmentLoaded(response));
      } on OnEnrollmentError {
        emit(const EnrollmentError('An error has occurred'));
      }
    });
  }
}
