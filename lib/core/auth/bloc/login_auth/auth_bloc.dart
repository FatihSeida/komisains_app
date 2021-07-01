import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:komisains_app/core/auth/repositories/login_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.loginAuthRepository,
  }) : super(AuthInitial());

  final LoginAuthRepository loginAuthRepository;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LogIn) {
      yield* mapLogInToState(event.email, event.password);
    } else if (event is LogOut) {
      yield* mapLogOutToState();
    }
  }

  Stream<AuthState> mapLogInToState(String email, String password) async* {
    yield AuthStateLoading();
    try {
      final isAuth = await loginAuthRepository.login(email, password);
      yield AuthStateAuthenticated(isAuth: isAuth);
    } catch (message) {
      yield AuthStateUnauthenticated();
    }
  }

  Stream<AuthState> mapLogOutToState() async* {
    await loginAuthRepository.logout();
    yield AuthStateUnauthenticated();
  }
}
