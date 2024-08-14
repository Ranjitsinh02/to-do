import 'package:equatable/equatable.dart';
import 'package:to_do_list/src/feature/domain/models/task_model.dart';

class ToDoListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToDoListInitial extends ToDoListState {}

class ToDoListLoading extends ToDoListState {}

class ToDoListLoaded extends ToDoListState {
  final List<TaskModel> taskModel;

  ToDoListLoaded({required this.taskModel});

  @override
  List<Object?> get props => [taskModel];
}

class ToDoListMessage extends ToDoListState {
  final String message;

  ToDoListMessage({required this.message});

  @override
  List<Object?> get props => [message];
}

class ToDoListError extends ToDoListState {
  final String error;

  ToDoListError({required this.error});

  @override
  List<Object?> get props => [error];
}
