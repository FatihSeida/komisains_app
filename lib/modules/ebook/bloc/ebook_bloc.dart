import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ebook_event.dart';
part 'ebook_state.dart';

class EbookBloc extends Bloc<EbookEvent, EbookState> {
  EbookBloc() : super(EbookInitial());

  @override
  Stream<EbookState> mapEventToState(
    EbookEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
