import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tes_garda_medica/data/api/service_api.dart';
import 'package:tes_garda_medica/data/model/todo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> showListData() async {
    emit(HomeInitial());

    try {
      var result = await ServicesApi().getAllToDo();

      if (result.isNotEmpty) {
        emit(HomeListData(todos: result));
      } else {
        emit(HomeError(message: 'To Do List is Empty'));
      }
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> deleteData(int todoId) async {
    emit(HomeInitial());

    try {
      var delete = await ServicesApi().deleteTodo(todoId);

      if (delete == 200) {
        var result = await ServicesApi().getAllToDo();

        if (result.isNotEmpty) {
          emit(HomeListData(todos: result));
        } else {
          emit(HomeError(message: 'To Do List is Empty'));
        }
      } else {
        emit(HomeError(message: 'Failed Delete'));
      }
    } catch (e) {
      emit(HomeError(message: 'Failed Delete'));
    }
  }

  // Future<void> showUpdateForm() async {
  //   emit(HomeUpdateForm());
  // }

  // Future<void> showAddForm() async {
  //   emit(HomeAddForm());
  // }
}
