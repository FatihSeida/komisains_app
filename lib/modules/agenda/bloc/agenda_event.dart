part of 'agenda_bloc.dart';

abstract class AgendaEvent extends Equatable {
  const AgendaEvent();

  @override
  List<Object> get props => [];
}

class FetchAgenda extends AgendaEvent {}
