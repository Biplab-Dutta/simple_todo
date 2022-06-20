part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodosRequested extends TodosEvent {
  const TodosRequested();
}

class TodoAdded extends TodosEvent {
  const TodoAdded({required this.todo});

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class TodoCompletionToggled extends TodosEvent {
  const TodoCompletionToggled({
    required this.todo,
    required this.isCompleted,
  });

  final Todo todo;
  final bool isCompleted;

  @override
  List<Object> get props => [todo, isCompleted];
}
