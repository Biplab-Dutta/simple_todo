import 'package:flutter/material.dart';
import 'package:todos_flutter_bloc_demo/todo/domain/todo.dart';

class TodosListTile extends StatelessWidget {
  const TodosListTile({
    required this.todo,
    this.onToggleCompleted,
    this.shouldApplyStrikeThrough = false,
    super.key,
  });

  final Todo todo;
  final ValueChanged<bool>? onToggleCompleted;
  final bool shouldApplyStrikeThrough;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        todo.title,
        style: TextStyle(
          fontSize: 20,
          decoration:
              shouldApplyStrikeThrough ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(
        todo.description,
        style: TextStyle(
          decoration:
              shouldApplyStrikeThrough ? TextDecoration.lineThrough : null,
        ),
      ),
      value: todo.isCompleted,
      onChanged: onToggleCompleted == null
          ? null
          : (value) => onToggleCompleted!(value!),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
