import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_garda_medica/data/model/todo.dart';
import 'package:tes_garda_medica/state/cubit/add_edit_cubit.dart';

class AddEditForm extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final bool isEditing;
  final Todo? todo;

  AddEditForm({required this.isEditing, this.todo});

  @override
  _AddEditFormState createState() => _AddEditFormState();
}

class _AddEditFormState extends State<AddEditForm> {
  late String _title;

  late String _message;

  DateTime _time = DateTime.now();

  late String _selectedDate;

  bool showProgressIndicator = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isEditing) {
      _time = DateTime.parse(widget.todo!.time!);
      _title = widget.todo!.title!;
      _message = widget.todo!.message!;
      _selectedDate = _time.toString();
    }

    final _cubit = context.read<AddEditCubit>();

    return BlocListener<AddEditCubit, AddEditState>(
        listener: (context, state) {
          if (state is AddEditSuccess) {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Success'),
                      content: Text('data: ${state.todo!}'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ));
          }

          if (state is AddEditFailed) {
            Navigator.pop(context);

            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Failed'),
                      content: Text('${state.message}'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ));
          }

          if (state is AddEditProcessing) {
            setState(() {
              showProgressIndicator = true;
            });
            // showDialog(
            //     context: context,
            //     builder: (context) => AlertDialog(
            //           title: Text('Please Wait'),
            //           content: CircularProgressIndicator(),
            //         ));
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.isEditing ? "Edit To Do" : "Add To Do"),
              bottom: showProgressIndicator
                  ? PreferredSize(
                      preferredSize: Size(double.infinity, 1.0),
                      child: LinearProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.teal[50]!),
                      ))
                  : null,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              child: Icon(widget.isEditing ? Icons.check : Icons.add),
              onPressed: () {
                if (AddEditForm._formKey.currentState!.validate()) {
                  AddEditForm._formKey.currentState!.save();
                  Todo todo = Todo(
                      id: widget.isEditing ? widget.todo!.id : null,
                      title: _title,
                      message: _message,
                      time: _selectedDate);

                  widget.isEditing
                      ? _cubit.updateToDo(todo: todo)
                      : _cubit.addToDo(todo: todo);
                }
              },
            ),
            body: Padding(
              padding: EdgeInsets.all(24),
              child: Form(
                key: AddEditForm._formKey,
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      TextFormField(
                        initialValue:
                            widget.isEditing ? widget.todo!.title : '',
                        decoration: InputDecoration(
                            labelText: 'Title', border: OutlineInputBorder()),
                        validator: (val) {
                          return val!.trim().isEmpty ? 'Title cant null' : null;
                        },
                        onSaved: (val) => _title = val!,
                      ),
                      TextFormField(
                        initialValue:
                            widget.isEditing ? widget.todo!.message : '',
                        maxLines: 5,
                        decoration: InputDecoration(
                            labelText: 'Message', border: OutlineInputBorder()),
                        onSaved: (val) => _message = val!,
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.dateTime,
                        initialValue: _time.toString(),
                        firstDate: _time,
                        lastDate: DateTime(_time.year + 1),
                        dateMask: 'yyyy/MM/dd hh:mm',
                        onSaved: (val) => _selectedDate = val!,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Date & Time'),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
