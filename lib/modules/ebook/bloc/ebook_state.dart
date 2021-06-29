part of 'ebook_bloc.dart';

abstract class EbookState extends Equatable {
  const EbookState();
  
  @override
  List<Object> get props => [];
}

class EbookStateLoad extends EbookState {}

class EbookStateLoaded extends EbookState {
  final List<Book> books;

  EbookStateLoaded({
    required this.books,
  });

  @override
  List<Object> get props => [books];
}

class EbookStateError extends EbookState {}




