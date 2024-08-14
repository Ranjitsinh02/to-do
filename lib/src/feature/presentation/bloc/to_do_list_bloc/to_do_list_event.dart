import 'package:equatable/equatable.dart';
import 'package:to_do_list/src/feature/domain/models/task_model.dart';

class ToDoListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToDoListLoadEvent extends ToDoListEvent {
   String? query;

  ToDoListLoadEvent({this.query});

  @override
  List<Object?> get props => [query];
}
