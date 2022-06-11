import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_flutter_bloc_demo/todo/data/todo_repository.dart';
import 'package:todos_flutter_bloc_demo/todo/domain/todo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({
    required TodoRepository todoRepository,
  })  : _todoRepository = todoRepository,
        super(const TodosState()) {
    on<TodosRequested>(_onTodosRequested);
    on<TodoAdded>(_onTodoAdded);
    on<TodoCompletionToggled>(_onTodoCompletionToggled);
  }
  final TodoRepository _todoRepository;

  void _onTodosRequested(
    TodosRequested event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(status: TodoStatus.loading));
    await emit.forEach<List<Todo>>(
      _todoRepository.getTodos(),
      onData: (todos) => state.copyWith(
        status: TodoStatus.loaded,
        todos: todos,
      ),
      onError: (_, __) => state.copyWith(
        status: TodoStatus.failed,
      ),
    );
  }

  void _onTodoAdded(
    TodoAdded event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(status: TodoStatus.loading));
    final newTodo = event.todo.copyWith(
      title: event.todo.title,
      description: event.todo.description,
    );
    await _todoRepository.saveTodo(newTodo);
    emit(state.copyWith(status: TodoStatus.loaded));
  }

  void _onTodoCompletionToggled(
    TodoCompletionToggled event,
    Emitter<TodosState> emit,
  ) async {
    final updatedTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await _todoRepository.saveTodo(updatedTodo);
  }
}
