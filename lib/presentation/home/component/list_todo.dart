import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_garda_medica/data/model/todo.dart';
import 'package:tes_garda_medica/presentation/add_edit/add_edit_screen.dart';
import 'package:tes_garda_medica/state/cubit/home_cubit.dart';

class ListToDo extends StatelessWidget {
  ListToDo({required this.todos});

  final List<Todo> todos;

  _showDeleteDialog(BuildContext context, Todo todo, HomeCubit _cubit) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete To Do'),
              content: Text('Are want to delete To Do with id : ${todo.id}?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Sure'),
                  onPressed: () {
                    _cubit.deleteData(todo.id!);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    var _cubit = context.read<HomeCubit>();

    return Container(
      padding: EdgeInsets.all(8),
      child: ListView.separated(
        itemCount: todos.length,
        itemBuilder: (context, idx) {
          var todo = todos[idx];
          var time = DateTime.parse(todo.time!);
          var tanggal = DateFormat("yMd").format(time);
          var waktu = DateFormat("hh:mm").format(time);

          if (time.isBefore(DateTime.now())) {
            return TileToDo(
                time: time, tanggal: tanggal, waktu: waktu, todo: todo);
          } else
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Update',
                  color: Colors.teal,
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddEditScreen(
                                  isEditing: true,
                                  todo: todo,
                                )));
                  },
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => _showDeleteDialog(context, todo, _cubit),
                ),
              ],
              child: TileToDo(
                  time: time, tanggal: tanggal, waktu: waktu, todo: todo),
            );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 1,
            color: Colors.teal,
          );
        },
      ),
    );
  }
}

class TileToDo extends StatelessWidget {
  const TileToDo({
    Key? key,
    required this.time,
    required this.tanggal,
    required this.waktu,
    required this.todo,
  }) : super(key: key);

  final DateTime time;
  final String tanggal;
  final String waktu;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor:
          time.isBefore(DateTime.now()) ? Colors.black12 : Colors.teal[10],
      isThreeLine: true,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(tanggal), Text(waktu)],
      ),
      trailing: time.isBefore(DateTime.now())
          ? null
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.arrow_back),
              ],
            ),
      title: Text(
        todo.title!,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
      subtitle: Text(todo.message!),
    );
  }
}
