import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komisains_app/modules/ebook/models/books.dart';
import 'package:komisains_app/modules/ebook/repository/ebook_repository.dart';

part 'ebook_event.dart';
part 'ebook_state.dart';

class EbookBloc extends Bloc<EbookEvent, EbookState> {
  EbookBloc({required this.ebookRepository}) : super(EbookStateLoad());

  final EbookRepository ebookRepository;

  @override
  Stream<EbookState> mapEventToState(
    EbookEvent event,
  ) async* {
    if (event is FetchMateriWajib) {
      yield* _mapFetchMateriWajibToState();
    } else if (event is FetchResensi) {
      yield* _mapFetchResensiToState();
    }
  }

  Stream<EbookState> _mapFetchMateriWajibToState() async* {
    yield EbookStateLoad();
    try {
      final ebookData = await ebookRepository.fetchData('Materi Wajib');
      yield EbookStateLoaded(books: ebookData);
    } catch (_) {
      yield EbookStateError();
    }
  }

  Stream<EbookState> _mapFetchResensiToState() async* {
    yield EbookStateLoad();
    try {
      final ebookData = await ebookRepository.fetchData('Resensi');
      yield EbookStateLoaded(books: ebookData);
    } catch (_) {
      yield EbookStateError();
    }
  }
}
