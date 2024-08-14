import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/src/feature/data/repositories/to_do_repositories.dart';
import 'package:to_do_list/src/feature/presentation/bloc/to_do_list_bloc/to_do_list_event.dart';
import 'package:to_do_list/src/feature/presentation/bloc/to_do_list_bloc/to_do_list_state.dart';

class ToDoBloc extends Bloc<ToDoListEvent, ToDoListState> {
  final repository = ToDoRepositories();

  ToDoBloc() : super(ToDoListInitial()) {
    on<ToDoListLoadEvent>(
      (event, emit) async {
        emit(ToDoListLoading());
        try {
          final taskModel = await repository.getAllTask(query: event.query);
          emit(ToDoListLoaded(taskModel: taskModel));
        } catch (e) {
          emit(ToDoListError(error: e.toString()));
        }
      },
    );
  }
}
