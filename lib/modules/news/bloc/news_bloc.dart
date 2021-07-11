import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/modules/news/models/news.dart';
import 'package:komisains_app/modules/news/repositories/news_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required this.newsRepository}) : super(NewsInitial());

  final NewsRepository newsRepository;

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is FetchNews) {
      yield* mapFetchNewsToState();
    }
  }

  Stream<NewsState> mapFetchNewsToState() async* {
    yield NewsStateLoad();
    try {
      final newsData = await newsRepository.fetchData();
      yield NewsStateLoaded(news: newsData);
    } catch (_) {
      yield NewsStateError();
    }
  }
}
