part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LogIn extends AuthEvent {
  LogIn({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
  
  @override
  List<Object> get props => [email, password];
}

class LogOut extends AuthEvent {}
