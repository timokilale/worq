import 'package:attendance/models/login.dart';
import 'package:attendance/models/login_response.dart';
import 'package:attendance/repositories/login_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'login_event.dart';

part 'login_state.dart';

final _locator = GetIt.I;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<DoLogin>((event, emit) async {
      try {
        emit(LoginLoading());
        LoginResponse response =
            await _locator<LoginRepository>().doLogin(event.login);
        emit(LoginLoaded(response));
      } on OnLoginError {
        emit(const LoginError('An error has occurred'));
      }
    });
  }
}
