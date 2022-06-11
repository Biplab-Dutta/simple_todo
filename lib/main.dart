import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_flutter_bloc_demo/app.dart';
import 'package:todos_flutter_bloc_demo/todo/data/todo_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = TodoRepository(
    sharedPreferences: await SharedPreferences.getInstance(),
  );
  runApp(App(repository: repository));
}
