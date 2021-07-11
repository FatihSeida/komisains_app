import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/modules/agenda/models/agenda.dart';
import 'package:komisains_app/modules/agenda/repositories/agenda_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc({required this.agendaRepository}) : super(AgendaStateLoad());

  final AgendaRepository agendaRepository;

  @override
  Stream<AgendaState> mapEventToState(
    AgendaEvent event,
  ) async* {
    if (event is FetchAgenda) {
      yield* _mapFetchAgendaToState();
    }
  }

  Stream<AgendaState> _mapFetchAgendaToState() async* {
    yield AgendaStateLoad();
    try {
      final prefs = await SharedPreferences.getInstance();
      final extractedData = json.decode(prefs.getString('userData').toString());
      final token = extractedData['token'];
      final agendaData = await agendaRepository.fetchData(token);
      yield AgendaStateLoaded(calendar: agendaData);
    } catch (_) {
      yield AgendaStateError();
    } 
  }
}
