import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_flutter_bloc_demo/todo/domain/todo.dart';

class TodoRepository {
  TodoRepository({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences {
    _init();
  }

  final SharedPreferences _sharedPreferences;

  static const _kTodosStorageKey = 'todos_key_007';

  final _controller = BehaviorSubject<List<Todo>>();

  String? _getValue(String key) => _sharedPreferences.getString(key);

  Future<void> _setValue(String key, String value) =>
      _sharedPreferences.setString(key, value);

  void _init() {
    final todosJson = _getValue(_kTodosStorageKey);
    if (todosJson != null) {
      final todos = (jsonDecode(todosJson) as List)
          .map((e) => e as Map<String, dynamic>)
          .map(Todo.fromJson)
          .toList();
      _controller.add(todos);
    } else {
      _controller.add(const []);
    }
  }

  Stream<List<Todo>> getTodos() => _controller.stream.asBroadcastStream();

  Future<void> saveTodo(Todo todo) async {
    final todos = [..._controller.value];
    final index = todos.indexWhere((element) => element.id == todo.id);
    if (index >= 0) {
      todos[index] = todo;
    } else {
      todos.add(todo);
    }
    _controller.add(todos);
    return _setValue(_kTodosStorageKey, jsonEncode(todos));
  }

  Future<void> deleteTodo(Todo todo) {
    final todos = [..._controller.value];
    final todoIndex = todos.indexWhere((e) => e.id == todo.id);
    todos.removeAt(todoIndex);
    _controller.add(todos);
    return _setValue(_kTodosStorageKey, jsonEncode(todos));
  }

  void dispose() => _controller.close();
}
