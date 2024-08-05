
class TaskModel {
  int? id;
  String? title;
  bool? isCompleted;
  String? created;

  TaskModel({this.id, this.title, this.isCompleted, this.created});

  factory TaskModel.fromDatabaseJson(Map<String, dynamic> data) => TaskModel(
      id: data['id'] ?? 0,
      title: data['title'] ?? '',
      isCompleted: data['isCompleted'] ?? '',
      created: data['created'] ?? '');

  Map<String, dynamic> toDatabaseJson() {
    var map = {
      "title": title ?? '',
      "isCompleted": isCompleted ?? '',
      "created": created ?? ''
    };

    if (map['id'] != null) map['id'] = (id) as String;

    return map;
  }
}
