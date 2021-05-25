import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_garda_medica/data/model/todo.dart';
import 'package:tes_garda_medica/state/cubit/add_edit_cubit.dart';

import 'component/add_edit_form.dart';

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final Todo? todo;

  AddEditScreen({Key? key, this.isEditing = false, this.todo})
      : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditCubit()..setInitial(),
      child: AddEditForm(
        isEditing: widget.isEditing,
        todo: widget.todo,
      ),
    );
  }
}
