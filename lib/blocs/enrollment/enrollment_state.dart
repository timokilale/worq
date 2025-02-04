part of 'enrollment_bloc.dart';

sealed class EnrollmentState extends Equatable {
  const EnrollmentState();

  @override
  List<Object> get props => [];
}

final class EnrollmentInitial extends EnrollmentState {}

final class EnrollmentLoading extends EnrollmentState {}

final class EnrollmentLoaded extends EnrollmentState {
  final UserResponse response;

  const EnrollmentLoaded(this.response);

  @override
  List<Object> get props => [response];
}

final class EnrollmentError extends EnrollmentState {
  final String message;

  const EnrollmentError(this.message);
}
