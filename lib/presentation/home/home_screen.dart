import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_garda_medica/presentation/add_edit/add_edit_screen.dart';
import 'package:tes_garda_medica/state/cubit/home_cubit.dart';

import 'component/list_todo.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do Apps'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeListData) {
            return ListToDo(
              todos: state.todos!,
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
        notchMargin: 8,
        child: Container(
          height: 48,
          color: Colors.teal,
        ),
      ),
    );
  }
}
