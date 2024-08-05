import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/src/core/helper/db_helper.dart';
import 'package:to_do_list/src/feature/domain/models/task_model.dart';


class TaskDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createTask(TaskModel task) async {
    final db = await dbProvider.database;
    try{
      var result = db.insert(taskTABLE, task.toDatabaseJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    }catch(e){
      print("Error::${e.toString()}");
    }
    return 1;
  }

  Future<List<TaskModel>> getTask({List<String>? columns, String? query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result = [];
    if (query != null && query != '') {
      if (query.isNotEmpty) {
        result = await db.query(taskTABLE,
            columns: columns, where: 'title LIKE ?', whereArgs: ["%$query%"]);
      }
    } else {
      result = await db.query(taskTABLE, columns: columns, orderBy: 'id DESC');
    }

    List<TaskModel> task = result.isNotEmpty
        ? result.map((item) => TaskModel.fromDatabaseJson(item)).toList()
        : [];
    return task;
  }

  Future<int> updateTask(TaskModel task) async {
    final db = await dbProvider.database;

    var result = await db.update(taskTABLE, task.toDatabaseJson(),
        where: "id = ?", whereArgs: [task.id]);

    return result;
  }

  Future<int> deleteTask(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(taskTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<TaskModel?> getNoteById({ List<String>? columns, required int id}) async {
    final db = await dbProvider.database;
    var result = await db
        .query(taskTABLE, columns: columns, where: 'id = ?', whereArgs: [id]);

    List<TaskModel> task = result.isNotEmpty
        ? result.map((task) => TaskModel.fromDatabaseJson(task)).toList()
        : [];
    TaskModel? tasks = task.isNotEmpty ? task[0] : null;

    return tasks;
  }

  Future deleteAllTask() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      taskTABLE,
    );

    return result;
  }
}
