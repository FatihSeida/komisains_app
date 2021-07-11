import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/modules/structure/models/structures.dart';
import 'package:komisains_app/modules/structure/repositories/structure_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'structure_event.dart';
part 'structure_state.dart';

class StructureBloc extends Bloc<StructureEvent, StructureState> {
  StructureBloc({required this.structureRepository}) : super(StructureInitial());

  final StructureRepository structureRepository;

  @override
  Stream<StructureState> mapEventToState(
    StructureEvent event,
  ) async* {
    if (event is FetchStructure) {
      yield* mapFetchStructureToState();
    }
  }

  Stream<StructureState> mapFetchStructureToState() async* {
    yield StructureStateLoad();
    try {
      final prefs = await SharedPreferences.getInstance();
      final extractedData = json.decode(prefs.getString('userData').toString());
      final token = extractedData['token'];
      final structureData = await structureRepository.fetchData(token);
      yield StructureStateLoaded(structure: structureData);
    } catch (_) {
      yield StructureStateError();
    }
  }
}
