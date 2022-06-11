part of 'todos_bloc.dart';

enum TodoStatus { initial, loading, loaded, failed }

class TodosState extends Equatable {
  const TodosState({
    this.status = TodoStatus.initial,
    this.todos = const [],
  });

  final TodoStatus status;
  final List<Todo> todos;

  TodosState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
  }) =>
      TodosState(
        status: status ?? this.status,
        todos: todos ?? this.todos,
      );

  @override
  List<Object> get props => [status, todos];
}
