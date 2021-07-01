import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/core/auth/repositories/sign_up_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required this.signUpRepository}) : super(SignUpInitial());

  final SignUpRepository signUpRepository;

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUp) {
      yield* mapSignUpToState(event.signUpData);
    }
  }

  Stream<SignUpState> mapSignUpToState(Map<String, String> signUpData) async* {
    try {
      final message = await signUpRepository.signup(signUpData);
      yield SignUpSuccess(message: message);
    } catch (message) {
      yield SignUpFailed(message: message);
    }
  }
}
