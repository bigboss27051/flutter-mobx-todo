import 'package:dio/dio.dart';
import 'package:mobx_todos/models/todo.dart';

class TodoRepository {
  Dio dio = new Dio();

  Future<List<Todo>> getList() async {
		print('before');
    final result = await dio.get('http://10.0.2.2:3000/todos');
		print('sss');
		print(result.data);
    List<Todo> todos =
        List<Todo>.from(result.data.map((i) => Todo.fromJson(i)));
    return todos;
  }

  Future<Todo> post(Todo todo) async {
    final result = await dio.post('http://10.0.2.2:3000/todos',
        data: {"text": todo.text, "completed": false});
    Todo _todo = Todo.fromJson(result.data);
    return _todo;
  }

  Future<Todo> update(Todo todo) async {
		print('param ${todo.toJson()}');
    final result = await dio.patch('http://10.0.2.2:3000/todos/${todo.id}',
        data: {"text": todo.text, "completed": todo.completed});
    Todo _todo = Todo.fromJson(result.data);
    return _todo;
  }

  Future<void> remove(int id) async {
    await dio.delete('http://10.0.2.2:3000/todos/$id');
  }
}

class NetworkError extends Error {}
