import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/modules/user_profile/models/user.dart';
import 'package:komisains_app/modules/user_profile/repositories/user_repository.dart';

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
}
