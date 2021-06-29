part of 'ebook_bloc.dart';

abstract class EbookEvent extends Equatable {
  const EbookEvent();

  @override
  List<Object> get props => [];
}

class FetchMateriWajib extends EbookEvent {}

class FetchResensi extends EbookEvent {}