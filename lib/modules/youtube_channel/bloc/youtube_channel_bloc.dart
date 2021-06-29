import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/modules/youtube_channel/models/youtube_channel.dart';
import 'package:komisains_app/modules/youtube_channel/repositories/youtube_repository.dart';

part 'youtube_channel_event.dart';
part 'youtube_channel_state.dart';

class YoutubeChannelBloc
    extends Bloc<YoutubeChannelEvent, YoutubeChannelState> {
  YoutubeChannelBloc({required this.youtubeRepository}) : super(YoutubeChannelInitial());

  final YoutubeRepository youtubeRepository;

  @override
  Stream<YoutubeChannelState> mapEventToState(
    YoutubeChannelEvent event,
  ) async* {
    if (event is FetchYoutubeVideo) {
      yield* _mapFetchYoutubeVideoToState();
    }
  }

  Stream<YoutubeChannelState> _mapFetchYoutubeVideoToState() async* {
    yield YoutubeChannelStateLoad();
    try {
      final youtubeVideoData = await youtubeRepository.fetchData();
      yield YoutubeChannelStateLoaded(datum: youtubeVideoData);
    } catch (_) {
      yield YoutubeChannelStateError();
    }
  }
}
