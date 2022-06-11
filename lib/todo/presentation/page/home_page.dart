import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_flutter_bloc_demo/todo/data/todo_repository.dart';
import 'package:todos_flutter_bloc_demo/todo/presentation/page/add_todo_page.dart';
import 'package:todos_flutter_bloc_demo/todo/presentation/todos_bloc/todos_bloc.dart';
import 'package:todos_flutter_bloc_demo/todo/presentation/widgets/todos_list_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc(
        todoRepository: context.read<TodoRepository>(),
      )..add(const TodosRequested()),
      child: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          switch (state.status) {
            case TodoStatus.loading:
              return const CircularProgressIndicator.adaptive();
            case TodoStatus.failed:
              return const Center(child: Text('Something went wrong!!!'));
            case TodoStatus.loaded:
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (state.todos.isEmpty) {
                    return const Center(
                      child: Text('No any todos. Add some todos...'),
                    );
                  }
                  return TodosListTile(
                    todo: state.todos[index],
                    onToggleCompleted: (isCompleted) {
                      context.read<TodosBloc>().add(
                            TodoCompletionToggled(
                              todo: state.todos[index],
                              isCompleted: isCompleted,
                            ),
                          );
                    },
                  );
                },
                itemCount: state.todos.length,
              );
            default: // initial status
              return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return BlocProvider.value(
                value: context.read<TodosBloc>(),
                child: const AddTodoPage(),
              );
            },
          ),
        ),
      ),
    );
  }
}
