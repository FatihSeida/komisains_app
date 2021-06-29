part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
  
  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsStateLoad extends NewsState {}

class NewsStateLoaded extends NewsState {
  final List<Article> news;

  NewsStateLoaded({
    required this.news,
  });

  @override
  List<Object> get props => [news];
}

class NewsStateError extends NewsState {}

