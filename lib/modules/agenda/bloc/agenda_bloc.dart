import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc() : super(AgendaInitial());

  @override
  Stream<AgendaState> mapEventToState(
    AgendaEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
