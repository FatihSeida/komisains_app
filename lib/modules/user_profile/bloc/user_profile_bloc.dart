import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/modules/user_profile/models/user.dart';
import 'package:komisains_app/modules/user_profile/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({
    required this.userRepository,
  }) : super(UserProfileInitial());

  final UserRepository userRepository;

  @override
  Stream<UserProfileState> mapEventToState(
    UserProfileEvent event,
  ) async* {
    if (event is FetchUserProfile) {
      yield* mapFetchUserProfileToState();
    }

    if (event is EditPassword) {
      yield* mapEditPasswordToState();
    }

    if (event is UploadPhotoProfile) {
      yield* mapUploadPhotoProfileToState();
    }

    if (event is UpdateProfile) {
      yield* mapUpdateProfileToState();
    }
  }

  Stream<UserProfileState> mapFetchUserProfileToState() async* {
    yield UserProfileStateLoad();
    try {
      final userData = await userRepository.getData();
      yield UserProfileStateLoaded(user: userData);
    } catch (_) {
      yield UserProfileStateError();
    }
  }

  Stream<UserProfileState> mapEditPasswordToState() async* {
    yield UserProfileStateLoad();
    try {
      final prefs = await SharedPreferences.getInstance();
      final extractedData = json.decode(prefs.getString('userData').toString());
      final token = extractedData['token'];
    } catch (e) {}
  }

  Stream<UserProfileState> mapUploadPhotoProfileToState() async* {
    yield UserProfileStateLoad();
    try {
      final prefs = await SharedPreferences.getInstance();
      final extractedData = json.decode(prefs.getString('userData').toString());
      final token = extractedData['token'];
    } catch (e) {}
  }

  Stream<UserProfileState> mapUpdateProfileToState() async* {
    yield UserProfileStateLoad();
    try {
      final prefs = await SharedPreferences.getInstance();
      final extractedData = json.decode(prefs.getString('userData').toString());
      final token = extractedData['token'];
    } catch (e) {}
  }
}
