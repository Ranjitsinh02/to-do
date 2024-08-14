import 'package:to_do_list/src/feature/domain/usecase/usecase.dart';

class ToDoRepositories{
  final taskDao = TaskDao();

  Future getAllTask({String? query}) => taskDao.getTask(query: query);

  Future getTaskById({required int id}) => taskDao.getNoteById(id: id);
}