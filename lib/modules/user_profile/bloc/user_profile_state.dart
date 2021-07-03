part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();
  
  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileStateLoad extends UserProfileState {}

class UserProfileStateLoaded extends UserProfileState {
  final UserClass user;

  UserProfileStateLoaded({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class UserProfileStateError extends UserProfileState {}
