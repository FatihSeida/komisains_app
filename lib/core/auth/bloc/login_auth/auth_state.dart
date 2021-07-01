part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateUnauthenticated extends AuthState {}

class AuthStateAuthenticated extends AuthState {
  final bool isAuth;

  AuthStateAuthenticated({required this.isAuth});

  @override
  List<Object> get props => [isAuth];
}
