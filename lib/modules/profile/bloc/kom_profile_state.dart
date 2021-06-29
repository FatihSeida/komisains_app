part of 'kom_profile_bloc.dart';

abstract class KomProfileState extends Equatable {
  const KomProfileState();
  
  @override
  List<Object> get props => [];
}

class KomProfileInitial extends KomProfileState {}

class KomProfileStateLoad extends KomProfileState {}

class KomProfileStateLoaded extends KomProfileState {
  final CakabaProfile komProfile;

  KomProfileStateLoaded({
    required this.komProfile,
  });

  @override
  List<Object> get props => [komProfile];
}

class KomProfileStateError extends KomProfileState {}


