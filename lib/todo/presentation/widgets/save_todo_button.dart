import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_flutter_bloc_demo/todo/domain/todo.dart';
import 'package:todos_flutter_bloc_demo/todo/presentation/bloc/todos_bloc.dart';

class SaveTodoButton extends StatelessWidget {
  const SaveTodoButton({
    required this.titleController,
    required this.descriptionController,
    super.key,
  });

  final TextEditingController titleController, descriptionController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Add Todo'),
      onPressed: () {
        context.read<TodosBloc>().add(
              TodoAdded(
                todo: Todo(
                  title: titleController.text,
                  description: descriptionController.text,
                ),
              ),
            );
        Navigator.pop(context);
      },
    );
  }
}
