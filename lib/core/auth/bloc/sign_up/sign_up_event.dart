part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUp extends SignUpEvent {
  final Map<String, String> signUpData;

  SignUp({required this.signUpData});

  @override
  List<Object> get props => [signUpData];
}
