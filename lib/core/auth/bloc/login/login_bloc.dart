import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/core/auth/bloc/authentication/authentication_bloc.dart';

import 'package:komisains_app/core/auth/repositories/login_auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.loginLoginRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial());

  final LoginAuthRepository loginLoginRepository;
  final AuthenticationBloc authenticationBloc;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LogIn) {
      yield* mapLogInToState(event.email, event.password);
    } 
  }

  Stream<LoginState> mapLogInToState(String email, String password) async* {
    yield LoginLoading();
    try {
      final isLogin = await loginLoginRepository.login(email, password);
      if (isLogin) {
        authenticationBloc.add(UserLoggedIn(isAuth: isLogin));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure();
      }
    } catch (message) {
      yield LoginFailure();
    }
  }
}
