import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/modules/profile/models/kom_profile.dart';
import 'package:komisains_app/modules/profile/repositories/kom_profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final prefs = await SharedPreferences.getInstance();
      final extractedData = json.decode(prefs.getString('userData').toString());
      final token = extractedData['token'];
      final komProfileData = await komProfileRepository.fetchData(token);
      yield KomProfileStateLoaded(komProfile: komProfileData);
    } catch (_) {
      yield KomProfileStateError();
    }
  }
}
