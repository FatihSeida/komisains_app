import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/modules/profile/models/kom_profile.dart';
import 'package:komisains_app/modules/profile/repositories/kom_profile_repository.dart';

part 'kom_profile_event.dart';
part 'kom_profile_state.dart';

class KomProfileBloc extends Bloc<KomProfileEvent, KomProfileState> {
  KomProfileBloc({required this.komProfileRepository})
      : super(KomProfileInitial());

  final KomProfileRepository komProfileRepository;

  @override
  Stream<KomProfileState> mapEventToState(
    KomProfileEvent event,
  ) async* {
    if (event is FetchKomProfile) {
      yield* mapFetchKomProfileToState();
    }
  }

  Stream<KomProfileState> mapFetchKomProfileToState() async* {
    yield KomProfileStateLoad();
    try {
      final komProfileData = await komProfileRepository.fetchData();
      yield KomProfileStateLoaded(komProfile: komProfileData);
    } catch (_) {
      yield KomProfileStateError();
    }
  }
}
