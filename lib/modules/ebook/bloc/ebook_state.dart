part of 'ebook_bloc.dart';

abstract class EbookState extends Equatable {
  const EbookState();
  
  @override
  List<Object> get props => [];
}

class EbookInitial extends EbookState {}
