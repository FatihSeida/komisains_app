import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'info_training_event.dart';
part 'info_training_state.dart';

class InfoTrainingBloc extends Bloc<InfoTrainingEvent, InfoTrainingState> {
  InfoTrainingBloc() : super(InfoTrainingInitial());

  @override
  Stream<InfoTrainingState> mapEventToState(
    InfoTrainingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
