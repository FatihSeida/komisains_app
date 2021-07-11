part of 'agenda_bloc.dart';

abstract class AgendaState extends Equatable {
  const AgendaState();

  @override
  List<Object> get props => [];
}

class AgendaStateLoad extends AgendaState {}

class AgendaStateLoaded extends AgendaState {
  final List<Calendar> calendar;

  AgendaStateLoaded({
    required this.calendar,
  });

  @override
  List<Object> get props => [calendar];
}

class AgendaStateError extends AgendaState {}
