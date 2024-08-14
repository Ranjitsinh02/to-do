import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/src/core/utils/constant/app_color.dart';
import 'package:to_do_list/src/core/utils/constant/app_strings.dart';
import 'package:to_do_list/src/feature/presentation/bloc/to_do_list_bloc/to_do_bloc.dart';
import 'package:to_do_list/src/feature/presentation/bloc/to_do_list_bloc/to_do_list_event.dart';
import 'package:to_do_list/src/feature/presentation/bloc/to_do_list_bloc/to_do_list_state.dart';
import 'package:to_do_list/src/feature/presentation/pages/add_task/add_task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ToDoBloc>(context).add(ToDoListLoadEvent());
  }

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
            return state.taskModel.length > 0
                ? ListView.builder(
                    itemCount: state.taskModel.length,
                    itemBuilder: (context, index) {
                      return buildRow(state, context, index);
                    },
                  )
                : const Center(child: Text("Please add today task!"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildRow(ToDoListLoaded state, BuildContext context, int index) {
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
                      state.taskModel[index].title ?? '',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )),
                Text(state.taskModel[index].created ?? ''),
                Visibility(
                  visible: state.taskModel[index].isCompleted == 1,
                  child: const Text(
                    AppStrings.taskCompleted,
                    style: TextStyle(
                        color: AppColors.darkBlue, fontStyle: FontStyle.italic),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskScreen(
                      taskModel: state.taskModel[index],
                    ),
                  ));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.edit,
                color: AppColors.darkBlue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
