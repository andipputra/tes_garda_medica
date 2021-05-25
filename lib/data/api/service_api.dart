import 'package:dio/dio.dart';
import 'package:tes_garda_medica/data/model/todo.dart';

class ServicesApi {
  Future<List<Todo>> getAllToDo() async {
    try {
      var response = await Dio().get(
          'https://my-json-server.typicode.com/andipputra/fake_api/todos?_sort=time&_order=desc');

      if (response.statusCode == 200) {
        var result =
            (response.data as List).map((x) => Todo.fromJson(x)).toList();

        return result;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<Todo?> getToDoById(int id) async {
    try {
      var response = await Dio().get(
          'https://my-json-server.typicode.com/andipputra/fake_api/todos/$id');

      if (response.statusCode == 200) {
        return Todo.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Todo?> addToDo(Todo todo) async {
    try {
      var response = await Dio().post(
          'https://my-json-server.typicode.com/andipputra/fake_api/todos',
          data: todo.toJson());

      if (response.statusCode == 201) {
        return Todo.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Todo?> updateTodo(Todo todo) async {
    try {
      var response = await Dio().put(
          'https://my-json-server.typicode.com/andipputra/fake_api/todos/${todo.id}',
          data: todo.toJson());
      if (response.statusCode == 200) {
        return Todo.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<int?> deleteTodo(int todoId) async {
    try {
      var response = await Dio().delete(
          'https://my-json-server.typicode.com/andipputra/fake_api/todos/$todoId');

      return response.statusCode;
    } catch (e) {
      return null;
    }
  }
}
