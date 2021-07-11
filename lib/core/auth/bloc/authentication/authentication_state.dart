part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationNotAuthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final dynamic userData;


  AuthenticationAuthenticated({this.userData});

  @override
  List<Object> get props => [userData];
}

class AuthenticationFailure extends AuthenticationState {
  // final String message;

  // AuthenticationFailure({required this.message});

  // @override
  // List<Object> get props => [message];
}
