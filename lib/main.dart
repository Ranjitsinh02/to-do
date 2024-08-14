import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/src/feature/presentation/bloc/add_task/add_task.dart';
import 'package:to_do_list/src/feature/presentation/bloc/to_do_list_bloc/to_do_bloc.dart';
import 'package:to_do_list/src/feature/presentation/pages/to_do_list/to_do_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ToDoBloc>(create: (_) => ToDoBloc()),
        BlocProvider<AddTaskBloc>(create: (_) => AddTaskBloc())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const ToDoListScreen()),
    );
  }
}
