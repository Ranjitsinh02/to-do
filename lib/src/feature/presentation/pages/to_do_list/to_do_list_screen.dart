import 'package:flutter/material.dart';
import 'package:to_do_list/src/core/utils/constant/app_color.dart';
import 'package:to_do_list/src/core/utils/constant/app_strings.dart';
import 'package:to_do_list/src/feature/presentation/pages/add_task/add_task.dart';
import 'package:to_do_list/src/feature/presentation/pages/to_do_list/task_list/task_list.dart';

import 'completed_task/task_completed_list.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(),
      body: DefaultTabController(
        length: 2,
        child: TabBarView(controller: tabController, children: const [
          TaskListScreen(),
          TaskCompletedListScreen(),
        ]),
      ),
      floatingActionButton: buildFloatingActionButtonWidget(),
    );
  }

  AppBar buildAppBarWidget() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        AppStrings.appName,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.darkBlue,
      bottom: TabBar(
          padding: EdgeInsets.zero,
          indicator: const UnderlineTabIndicator(),
          controller: tabController,
          tabs: [
            Container(
                padding: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Tab(
                  child: Icon(
                    Icons.add,
                    color:
                        tabController.index == 0 ? Colors.white : Colors.white38,
                  ),
                )),
            Container(
              padding: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Tab(
                child: Icon(
                  Icons.map,
                  color: tabController.index == 0 ? Colors.white38 : Colors.white,
                ),
              ),
            ),
          ]),
    );
  }

  Widget buildFloatingActionButtonWidget() {
    return FloatingActionButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(50))),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ));
      },
      backgroundColor: AppColors.darkBlue,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
