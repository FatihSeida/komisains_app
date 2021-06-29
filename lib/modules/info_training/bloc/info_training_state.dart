part of 'info_training_bloc.dart';

abstract class InfoTrainingState extends Equatable {
  const InfoTrainingState();
  
  @override
  List<Object> get props => [];
}

class InfoTrainingInitial extends InfoTrainingState {}

class InfoTrainingStateLoad extends InfoTrainingState {}

class InfoTrainingStateLoaded extends InfoTrainingState {
  final List<Info> books;

  InfoTrainingStateLoaded({
    required this.books,
  });

  @override
  List<Object> get props => [books];
}

class InfoTrainingStateError extends InfoTrainingState {}

