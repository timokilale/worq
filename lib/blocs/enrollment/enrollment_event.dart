part of 'enrollment_bloc.dart';

sealed class EnrollmentEvent extends Equatable {
  const EnrollmentEvent();

  @override
  List<Object> get props => [];
}

class Enroll extends EnrollmentEvent {
  final UserEnrollment enrollment;

  const Enroll(this.enrollment);

  @override
  List<Object> get props => [enrollment];
}

class OnEnrollmentError extends EnrollmentEvent {}
