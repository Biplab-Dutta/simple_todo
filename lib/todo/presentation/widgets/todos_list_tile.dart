import 'package:flutter/material.dart';
import 'package:todos_flutter_bloc_demo/todo/domain/todo.dart';

class TodosListTile extends StatelessWidget {
  const TodosListTile({
    required this.todo,
    this.onToggleCompleted,
    super.key,
  });

  final Todo todo;
  final ValueChanged<bool>? onToggleCompleted;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        todo.title,
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Text(todo.description),
      value: todo.isCompleted,
      onChanged: onToggleCompleted == null
          ? null
          : (value) => onToggleCompleted!(value!),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
