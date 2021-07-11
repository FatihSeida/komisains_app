part of 'info_training_bloc.dart';

abstract class InfoTrainingState extends Equatable {
  const InfoTrainingState();
  
  @override
  List<Object> get props => [];
}

class InfoTrainingInitial extends InfoTrainingState {}

class InfoTrainingStateLoad extends InfoTrainingState {}

class InfoTrainingStateLoaded extends InfoTrainingState {
  final List<Info> infoTraining;

  InfoTrainingStateLoaded({
    required this.infoTraining,
  });

  @override
  List<Object> get props => [infoTraining];
}

class InfoTrainingStateError extends InfoTrainingState {}

