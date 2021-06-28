import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'feeds_event.dart';
part 'feeds_state.dart';

class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  FeedsBloc() : super(FeedsInitial());

  @override
  Stream<FeedsState> mapEventToState(
    FeedsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
