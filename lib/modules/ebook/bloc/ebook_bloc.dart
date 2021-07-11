import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/modules/ebook/models/books.dart';
import 'package:komisains_app/modules/ebook/repository/ebook_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ebook_event.dart';
part 'ebook_state.dart';

class EbookBloc extends Bloc<EbookEvent, EbookState> {
  EbookBloc({required this.ebookRepository}) : super(EbookStateLoad());

  final EbookRepository ebookRepository;

  @override
  Stream<EbookState> mapEventToState(
    EbookEvent event,
  ) async* {
    if (event is FetchEbooks) {
      yield* _mapFetchEbooksToState();
    }
  }

  Stream<EbookState> _mapFetchEbooksToState() async* {
    yield EbookStateLoad();
    try {
      final prefs = await SharedPreferences.getInstance();
      final extractedUserData =
          json.decode(prefs.getString('userData').toString());
      final token = extractedUserData['token'];
      final ebookData = await ebookRepository.fetchData(token);
      yield EbookStateLoaded(books: ebookData);
    } catch (_) {
      yield EbookStateError();
    }
  }
}
