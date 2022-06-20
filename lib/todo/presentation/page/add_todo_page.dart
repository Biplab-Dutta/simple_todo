import 'package:flutter/material.dart';
import 'package:todos_flutter_bloc_demo/todo/presentation/widgets/custom_textfield.dart';
import 'package:todos_flutter_bloc_demo/todo/presentation/widgets/save_todo_button.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _titleController,
              labelText: 'Title',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _descriptionController,
              labelText: 'Description',
            ),
            const SizedBox(height: 40),
            SaveTodoButton(
              titleController: _titleController,
              descriptionController: _descriptionController,
            ),
          ],
        ),
      ),
    );
  }
}
