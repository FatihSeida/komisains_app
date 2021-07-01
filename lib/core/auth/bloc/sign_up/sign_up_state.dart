part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String message;

  SignUpSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class SignUpFailed extends SignUpState {
  final Object message;

  SignUpFailed({required this.message});

  @override
  List<Object> get props => [message];
}
