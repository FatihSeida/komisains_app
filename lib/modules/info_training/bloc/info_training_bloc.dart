import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:komisains_app/modules/info_training/models/training_information_item.dart';
import 'package:komisains_app/modules/info_training/repositories/info_training_repository.dart';

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
      final ebookData = await infoTrainingRepository.fetchData();
      yield InfoTrainingStateLoaded(books: ebookData);
    } catch (_) {
      yield InfoTrainingStateError();
    }
  }
}
