import 'package:to_do_list/src/feature/domain/models/task_model.dart';
import 'package:to_do_list/src/feature/domain/usecase/usecase.dart';

class TaskRepository {
  final taskDao = TaskDao();

  Future getAllTask({String? query}) => taskDao.getTask(query: query);

  Future getTaskById({required int id}) => taskDao.getNoteById(id: id);

  Future insertTask(TaskModel task) => taskDao.createTask(task);

  Future updateTask(TaskModel task) => taskDao.updateTask(task);

  Future deleteTaskById(int id) => taskDao.deleteTask(id);

  Future deleteAllTask() => taskDao.deleteAllTask();
}