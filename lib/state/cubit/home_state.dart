part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeListData extends HomeState {
  final List<Todo>? todos;

  HomeListData({this.todos});

  @override
  List<Object?> get props => [todos];
}

class HomeError extends HomeState {
  final String? message;

  HomeError({this.message});

  @override
  List<Object?> get props => [message];
}
