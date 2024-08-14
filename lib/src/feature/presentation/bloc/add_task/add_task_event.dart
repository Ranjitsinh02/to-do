import 'package:equatable/equatable.dart';
import 'package:to_do_list/src/feature/domain/models/task_model.dart';

abstract class AddTaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectDateEvent extends AddTaskEvent {
  var selectedDate;

  SelectDateEvent(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}

class CreateToDOEvent extends AddTaskEvent {
  final TaskModel taskModel;

  CreateToDOEvent({required this.taskModel});

  @override
  List<Object?> get props => [taskModel];
}

class UpdateToDoEvent extends AddTaskEvent {
  final TaskModel taskModel;

  UpdateToDoEvent({required this.taskModel});

  @override
  List<Object?> get props => [taskModel];
}

class DeleteToDoEvent extends AddTaskEvent {
  final TaskModel taskModel;

  DeleteToDoEvent({required this.taskModel});

  @override
  List<Object?> get props => [taskModel];
}

class TaskCompleteToggleEvent extends AddTaskEvent{
  final bool? isTaskCompleted;

  TaskCompleteToggleEvent({this.isTaskCompleted});
}
