part of 'agenda_bloc.dart';

abstract class AgendaState extends Equatable {
  const AgendaState();
  
  @override
  List<Object> get props => [];
}

class AgendaInitial extends AgendaState {}
