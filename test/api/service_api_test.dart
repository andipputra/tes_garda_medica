import 'package:flutter_test/flutter_test.dart';
import 'package:tes_garda_medica/data/api/service_api.dart';
import 'package:tes_garda_medica/data/model/todo.dart';

void main() {
  final serviceApi = ServicesApi();

  group('add data', () {
    test('Create a new todo', () async {
      var todo = Todo(
          title: 'Make phone call',
          message: 'Call Mama',
          time: DateTime.now().toString());

      var result = await serviceApi.addToDo(todo);

      expect(result, isNotNull);
      expect(result, isA<Todo>());
    });
  });

  group('update data', () {
    test('update a todo', () async {
      Todo? todo = Todo(
          id: 2,
          title: 'Make phone call',
          message: 'Call Mama',
          time: DateTime.now().toString());

      var result = await serviceApi.updateTodo(todo);

      expect(result, isNotNull);
      expect(result, isA<Todo>());
      expect(result!.toJson().toString(), todo.toJson().toString());
    });
  });

  group('get data', () {
    test('get all data', () async {
      var result = await serviceApi.getAllToDo();

      expect(result, isNotEmpty);
      expect(result, isA<List<Todo>>());
    });

    test('get by id 2', () async {
      var result = await serviceApi.getToDoById(2);

      expect(result, isNotNull);
      expect(result, isA<Todo>());
    });

    test('get by id 200 (false)', () async {
      var id = 220;

      var result = await serviceApi.getToDoById(id);

      expect(result, isNull);
      // expect(result, isA<Todo>());
    });
  });

  group('delete data', () {
    test('delete a todo', () async {
      Todo? todo = Todo(
          id: 1,
          title: 'Make phone call',
          message: 'Call Mama',
          time: DateTime.now().toString());

      var result = await serviceApi.deleteTodo(todo.id!);

      expect(result, isNotNull);
      expect(result, isA<int>());
      expect(result, 200);
    });
  });
}
