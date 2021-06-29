part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthStateUnauthenticated extends AuthState {}

class AuthStateAuthenticated extends AuthState {
  final Auth auth;

  AuthStateAuthenticated({required this.auth});

  @override
  List<Object> get props => [auth];
}
