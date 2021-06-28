import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'structure_event.dart';
part 'structure_state.dart';

class StructureBloc extends Bloc<StructureEvent, StructureState> {
  StructureBloc() : super(StructureInitial());

  @override
  Stream<StructureState> mapEventToState(
    StructureEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
