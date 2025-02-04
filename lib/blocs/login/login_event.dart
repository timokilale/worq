part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class DoLogin extends LoginEvent {
  final Login login;

  const DoLogin(this.login);

  @override
  List<Object> get props => [login];
}

class OnLoginError extends LoginEvent {}
