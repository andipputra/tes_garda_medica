import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tes_garda_medica/data/model/todo.dart';
import 'package:tes_garda_medica/presentation/add_edit_screen.dart';
import 'package:tes_garda_medica/state/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _cubit = context.read<HomeCubit>();

    _showDeleteDialog(BuildContext context, Todo todo) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('To Do Apps'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeListData) {
            return Container(
              padding: EdgeInsets.all(8),
              child: ListView.separated(
                itemCount: state.todos!.length,
                itemBuilder: (context, idx) {
                  var todo = state.todos![idx];
                  var time = DateTime.parse(todo.time!);
                  var tanggal = DateFormat("dd-MM-yy").format(time);
                  var waktu = DateFormat("hh:mm").format(time);

                  var trailingListMenu = Wrap(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEditScreen(
                                          isEditing: true,
                                          todo: todo,
                                        )));
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _showDeleteDialog(context, todo);
                          }),
                    ],
                  );

                  return Container(
                    child: ListTile(
                      isThreeLine: true,
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(tanggal), Text(waktu)],
                      ),
                      trailing: trailingListMenu,
                      title: Text(
                        todo.title!,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                      subtitle: Text(todo.message!),
                    ),
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

          if (state is HomeError) {
            return Container(
              child: Text(state.message!),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddEditScreen()));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 24,
        child: Container(
          height: 48,
          color: Colors.teal,
        ),
      ),
    );
  }
}
