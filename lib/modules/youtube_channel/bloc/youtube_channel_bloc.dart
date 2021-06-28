import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'youtube_channel_event.dart';
part 'youtube_channel_state.dart';

class YoutubeChannelBloc extends Bloc<YoutubeChannelEvent, YoutubeChannelState> {
  YoutubeChannelBloc() : super(YoutubeChannelInitial());

  @override
  Stream<YoutubeChannelState> mapEventToState(
    YoutubeChannelEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
