part of 'feeds_bloc.dart';

abstract class FeedsState extends Equatable {
  const FeedsState();
  
  @override
  List<Object> get props => [];
}

class FeedsInitial extends FeedsState {}
