part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginLoaded extends LoginState {
  final LoginResponse response;

  const LoginLoaded(this.response);

  @override
  List<Object> get props => [response];
}

final class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);
}
