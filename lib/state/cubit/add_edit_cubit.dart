import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tes_garda_medica/data/api/service_api.dart';
import 'package:tes_garda_medica/data/model/todo.dart';

part 'add_edit_state.dart';

class AddEditCubit extends Cubit<AddEditState> {
  AddEditCubit() : super(AddEditInitial());

  Future<void> setInitial() async {
    emit(AddEditInitial());
  }

  Future<void> addToDo({Todo? todo}) async {
    emit(AddEditProcessing());

    try {
      var result = await ServicesApi().addToDo(todo!);

      if (result != null) {
        emit(AddEditSuccess(todo: result));
      } else {
        emit(AddEditFailed(message: 'Add Edit Failed'));
      }
    } catch (e) {
      emit(AddEditFailed(message: 'Add Edit Failed'));
    }
  }

  Future<void> updateToDo({Todo? todo}) async {
    emit(AddEditProcessing());

    try {
      var result = await ServicesApi().updateTodo(todo!);

      if (result != null) {
        emit(AddEditSuccess(todo: result));
      } else {
        emit(AddEditFailed(message: 'Add Edit Failed'));
      }
    } catch (e) {
      emit(AddEditFailed(message: 'Add Edit Failed'));
    }
  }
}
