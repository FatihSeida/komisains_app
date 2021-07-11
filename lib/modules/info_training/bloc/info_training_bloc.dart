import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:komisains_app/modules/info_training/models/training_information_item.dart';
import 'package:komisains_app/modules/info_training/repositories/info_training_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'info_training_event.dart';
part 'info_training_state.dart';

class InfoTrainingBloc extends Bloc<InfoTrainingEvent, InfoTrainingState> {
  InfoTrainingBloc({
    required this.infoTrainingRepository,
  }) : super(InfoTrainingInitial());

  final InfoTrainingRepository infoTrainingRepository;

  @override
  Stream<InfoTrainingState> mapEventToState(
    InfoTrainingEvent event,
  ) async* {
    if (event is FetchInfoTraining) {
      yield* mapFetchInfoTrainingToState();
    }
  }

  Stream<InfoTrainingState> mapFetchInfoTrainingToState() async* {
    yield InfoTrainingStateLoad();
    try {
      final prefs = await SharedPreferences.getInstance();
      final extractedData = json.decode(prefs.getString('userData').toString());
      final token = extractedData['token'];
      final infoTraining = await infoTrainingRepository.fetchData(token);
      yield InfoTrainingStateLoaded(infoTraining: infoTraining);
    } catch (_) {
      yield InfoTrainingStateError();
    }
  }
}
