import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_flutter_bloc_demo/todo/data/todo_repository.dart';
import 'package:todos_flutter_bloc_demo/todo/presentation/page/home_page.dart';

class App extends StatelessWidget {
  const App({
    required this.repository,
    super.key,
  });

  final TodoRepository repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomePage(),
      ),
    );
  }
}
