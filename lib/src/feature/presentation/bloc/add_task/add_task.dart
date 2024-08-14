import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/src/core/utils/constant/app_strings.dart';
import 'package:to_do_list/src/feature/data/repositories/task_repositories.dart';
import 'package:to_do_list/src/feature/presentation/bloc/add_task/add_task_event.dart';
import 'package:to_do_list/src/feature/presentation/bloc/add_task/add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final taskRepository = TaskRepository();

  AddTaskBloc() : super(AddTaskInitial()) {
    on<SelectDateEvent>(
      (event, emit) {
        emit(DatePickerSelected(selectedDate: event.selectedDate));
      },
    );
    on<CreateToDOEvent>(
      (event, emit) async {
        emit(AddTaskLoading());
        if (event.taskModel != null) {
          try {
            await taskRepository.insertTask(event.taskModel);
            emit(TaskAddedMessage(
                message: event.taskModel.title ?? '' + "Created"));
          } catch (e) {
            emit(TaskError(error: e.toString()));
          }
        }
      },
    );
    on<UpdateToDoEvent>(
      (event, emit) async {
        emit(AddTaskLoading());
        if (event.taskModel != null) {
          try {
            await taskRepository.updateTask(event.taskModel);
            emit(TaskAddedMessage(
                message: event.taskModel.title ?? '' + "Update"));
          } catch (e) {
            emit(TaskError(error: e.toString()));
          }
        }
      },
    );
    on<DeleteToDoEvent>(
      (event, emit) async {
        emit(AddTaskLoading());
        try {
          await taskRepository.deleteTaskById(event.taskModel.id!);
          emit(TaskAddedMessage(message: AppStrings.toDoDeleteSuccessfully));
        } catch (e) {
          emit(TaskError(error: e.toString()));
        }
      },
    );
    on<TaskCompleteToggleEvent>(
      (event, emit) {
        emit(AddTaskLoading());
        try {
          emit(TaskCompletedState(
              isTaskCompleted: event.isTaskCompleted ?? false));
        } catch (e) {
          emit(TaskError(error: e.toString()));
        }
      },
    );
  }
}
