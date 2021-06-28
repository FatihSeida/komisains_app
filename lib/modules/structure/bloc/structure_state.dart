part of 'structure_bloc.dart';

abstract class StructureState extends Equatable {
  const StructureState();
  
  @override
  List<Object> get props => [];
}

class StructureInitial extends StructureState {}
