part of 'structure_bloc.dart';

abstract class StructureState extends Equatable {
  const StructureState();
  
  @override
  List<Object> get props => [];
}

class StructureInitial extends StructureState {}

class StructureStateLoad extends StructureState {}

class StructureStateLoaded extends StructureState {
  final List<Structure> structure;

  StructureStateLoaded({
    required this.structure,
  });

  @override
  List<Object> get props => [structure];
}

class StructureStateError extends StructureState {}
