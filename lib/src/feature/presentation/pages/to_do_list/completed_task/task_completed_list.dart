import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/src/feature/domain/models/task_model.dart';
import 'package:to_do_list/src/feature/presentation/bloc/to_do_list_bloc/to_do_bloc.dart';
import 'package:to_do_list/src/feature/presentation/bloc/to_do_list_bloc/to_do_list_event.dart';
import 'package:to_do_list/src/feature/presentation/bloc/to_do_list_bloc/to_do_list_state.dart';
import 'package:to_do_list/src/feature/presentation/pages/add_task/add_task.dart';

import '../../../../../core/utils/constant/app_color.dart';
import '../../../../../core/utils/constant/app_strings.dart';

class TaskCompletedListScreen extends StatefulWidget {
  const TaskCompletedListScreen({super.key});

  @override
  State<TaskCompletedListScreen> createState() =>
      _TaskCompletedListScreenState();
}

class _TaskCompletedListScreenState extends State<TaskCompletedListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ToDoBloc>(context).add(ToDoListLoadEvent());
  }

  List<TaskModel> taskModelList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ToDoBloc, ToDoListState>(
        builder: (context, state) {
          if (state is ToDoListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          print("state::${state}");
          if (state is ToDoListLoaded) {
            taskModelList.clear();
            for (int i = 0; i < state.taskModel.length; i++) {
              if (state.taskModel[i].isCompleted == 1) {
                taskModelList.add(state.taskModel[i]);
              }
            }
            return taskModelList.length > 0
                ? ListView.builder(
                    itemCount: taskModelList.length,
                    itemBuilder: (context, index) {
                      return buildRow(taskModelList, context, index);
                    },
                  )
                : const Center(child: Text("No completed task yet!"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildRow(
      List<TaskModel> taskModelList, BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      taskModelList[index].title ?? '',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )),
                Text(taskModelList[index].created ?? ''),
                const Text(
                  AppStrings.taskCompleted,
                  style: TextStyle(
                      color: AppColors.darkBlue, fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
          Visibility(
            visible: false,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTaskScreen(
                        taskModel: taskModelList[index],
                      ),
                    ));
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
