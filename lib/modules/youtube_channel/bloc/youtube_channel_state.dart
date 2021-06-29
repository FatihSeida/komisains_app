part of 'youtube_channel_bloc.dart';

abstract class YoutubeChannelState extends Equatable {
  const YoutubeChannelState();
  
  @override
  List<Object> get props => [];
}

class YoutubeChannelInitial extends YoutubeChannelState {}

class YoutubeChannelStateLoad extends YoutubeChannelState {}

class YoutubeChannelStateLoaded extends YoutubeChannelState {
  final List<Datum> datum;

  YoutubeChannelStateLoaded({
    required this.datum,
  });

  @override
  List<Object> get props => [datum];
}

class YoutubeChannelStateError extends YoutubeChannelState {}
