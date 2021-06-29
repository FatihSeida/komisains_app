part of 'kom_profile_bloc.dart';

abstract class KomProfileEvent extends Equatable {
  const KomProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchKomProfile extends KomProfileEvent {}
