part of 'add_edit_cubit.dart';

abstract class AddEditState extends Equatable {
  const AddEditState();

  @override
  List<Object?> get props => [];
}

class AddEditInitial extends AddEditState {}

class AddEditProcessing extends AddEditState {}

class AddEditSuccess extends AddEditState {
  final Todo? todo;

  AddEditSuccess({this.todo});

  @override
  List<Object?> get props => [todo];
}

class AddEditFailed extends AddEditState {
  final String? message;

  AddEditFailed({this.message});

  @override
  List<Object?> get props => [message];
}
