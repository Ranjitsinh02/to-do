import 'package:equatable/equatable.dart';
import 'package:to_do_list/src/feature/domain/models/task_model.dart';

abstract class AddTaskState extends Equatable {
  final TaskModel? taskModel;
  final String? message;
  final String? error;
  final DateTime? selectedDate;
  final bool? isTaskCompleted;

  AddTaskState({
    this.taskModel,
    this.message,
    this.error,
    this.selectedDate,
    this.isTaskCompleted,
  });

  @override
  List<Object?> get props => [];
}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class TaskAddedSuccess extends AddTaskState {
  TaskAddedSuccess({required TaskModel taskModel})
      : super(taskModel: taskModel);
}

class DatePickerSelected extends AddTaskState {
  DatePickerSelected({required DateTime selectedDate})
      : super(selectedDate: selectedDate);
}

class TaskAddedMessage extends AddTaskState {
  TaskAddedMessage({required String message}) : super(message: message);
}

class TaskError extends AddTaskState {
  TaskError({required String error}) : super(error: error);
}

class TaskCompletedState extends AddTaskState{
  TaskCompletedState({required bool isTaskCompleted}):super(isTaskCompleted: isTaskCompleted);
}