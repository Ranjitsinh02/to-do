import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/src/core/utils/constant/app_color.dart';
import 'package:to_do_list/src/core/utils/constant/app_strings.dart';
import 'package:to_do_list/src/feature/domain/models/task_model.dart';
import 'package:to_do_list/src/feature/presentation/bloc/add_task/add_task.dart';
import 'package:to_do_list/src/feature/presentation/bloc/add_task/add_task_event.dart';
import 'package:to_do_list/src/feature/presentation/bloc/add_task/add_task_state.dart';
import 'package:to_do_list/src/feature/presentation/pages/to_do_list/to_do_list_screen.dart';
import 'package:to_do_list/src/feature/presentation/widgets/custom_text_form_field_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, this.taskModel});

  final TaskModel? taskModel;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      context.read<AddTaskBloc>().add(SelectDateEvent(picked));
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.taskModel != null) {
      TaskModel taskModel = TaskModel();
      taskModel.title = widget.taskModel?.title ?? '';
      taskModel.created = widget.taskModel?.created ?? '';
      taskModel.isCompleted = widget.taskModel?.isCompleted ?? 0;
      bool isCompleted =
          widget.taskModel?.isCompleted == 0 ? false : true;
      context
          .read<AddTaskBloc>()
          .add(TaskCompleteToggleEvent(isTaskCompleted: isCompleted));
      titleController.text = widget.taskModel?.title ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.taskModel != null ? AppStrings.editTask : AppStrings.addTask,
          style: const TextStyle(color: Colors.white),
        ),
        leading: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ToDoListScreen(),
              )),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.darkBlue,
      ),
      body: buildSingleChildScrollViewWidget(context, width),
    );
  }

  Widget buildSingleChildScrollViewWidget(BuildContext context, double width) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: BlocConsumer<AddTaskBloc, AddTaskState>(
          listener: (context, state) {
            if (state is TaskAddedMessage) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ToDoListScreen(),
                  ));
            }
          },
          builder: (context, state) {
            if (state is TaskAddedSuccess) {
              TaskModel? task =
                  state.taskModel?.id == null ? TaskModel() : state.taskModel;
              return buildColumn(task ?? TaskModel(), context, width, state);
            }

            return buildColumn(
                state.taskModel ?? TaskModel(), context, width, state);
          },
        ),
      ),
    );
  }

  Widget buildColumn(
      TaskModel task, BuildContext context, double width, AddTaskState state) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Visibility(
            visible: widget.taskModel != null,
            child: checkBoxWidget(state, context)),
        Visibility(visible: widget.taskModel != null, child: buildSizedBox()),
        taskTitleWidget(task),
        buildSizedBox(),
        taskDateWidget(context, task),
        buildSizedBox(),
        saveButtonWidget(width, task, context),
        Visibility(
          visible: widget.taskModel != null,
          child: buildSizedBox(),
        ),
        deleteButtonWidget(width, task, context)
      ],
    );
  }

  Widget checkBoxWidget(AddTaskState state, BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: state is TaskCompletedState ? state.isTaskCompleted : false,
          onChanged: (value) {
            if (value != null) {
              context
                  .read<AddTaskBloc>()
                  .add(TaskCompleteToggleEvent(isTaskCompleted: value));
            }
          },
        ),
        const Text(AppStrings.markAsDone)
      ],
    );
  }

  Widget buildSizedBox() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget deleteButtonWidget(
      double width, TaskModel task, BuildContext context) {
    return Visibility(
      visible: widget.taskModel != null,
      child: ButtonTheme(
        minWidth: width,
        height: 50,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: width,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBlue,
              ),
              onPressed: () {
                deleteButtonOnPressed(task, context);
              },
              child: const Text(AppStrings.delete,
                  style: TextStyle(color: Colors.white))),
        ),
      ),
    );
  }

  void deleteButtonOnPressed(TaskModel task, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      task.id = widget.taskModel?.id ?? 0;
      task.title = widget.taskModel?.title ?? '';
      task.created = widget.taskModel?.created ?? '';
      BlocProvider.of<AddTaskBloc>(context)
          .add(DeleteToDoEvent(taskModel: task));
    }
  }

  Widget saveButtonWidget(double width, TaskModel task, BuildContext context) {
    return ButtonTheme(
      minWidth: width,
      height: 50,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkBlue,
            ),
            onPressed: () {
              saveButtonOnPressed(task, context);
            },
            child: const Text(AppStrings.save,
                style: TextStyle(color: Colors.white))),
      ),
    );
  }

  void saveButtonOnPressed(TaskModel task, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (widget.taskModel != null) {
        task.id = widget.taskModel?.id;
        task.title = titleController.text;
        task.created = widget.taskModel?.created;
        bool isCompleted =
            context.read<AddTaskBloc>().state.isTaskCompleted ?? false;
        print("bool::${isCompleted}");
        task.isCompleted = isCompleted == false ? 0 : 1;
        BlocProvider.of<AddTaskBloc>(context)
            .add(UpdateToDoEvent(taskModel: task ?? TaskModel()));
      } else {
        task.title = titleController.text;
        bool isCompleted =
            context.read<AddTaskBloc>().state.isTaskCompleted ?? false;
        task.isCompleted = isCompleted == false ? 0 : 1;
        BlocProvider.of<AddTaskBloc>(context)
            .add(CreateToDOEvent(taskModel: task ?? TaskModel()));
      }
    }
  }

  Widget taskDateWidget(BuildContext context, TaskModel task) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          _selectDate(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<AddTaskBloc, AddTaskState>(
                builder: (context, state) {
                  if (state is DatePickerSelected) {
                    task.created =
                        "${state.selectedDate?.toLocal()}".split(' ')[0];
                    return Text(
                        "${state.selectedDate?.toLocal()}".split(' ')[0]);
                  }
                  return Text(widget.taskModel != null
                      ? widget.taskModel?.created ?? ''
                      : AppStrings.pickDate);
                },
              ),
              const Icon(Icons.calendar_month)
            ],
          ),
        ),
      ),
    );
  }

  Widget taskTitleWidget(TaskModel task) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormFieldWidget(
        labelText: AppStrings.title,
        controller: titleController,
        initialValue: task.title,
        validator: (value) {
          if ((value?.length ?? 0) < 1) {
            return AppStrings.taskCanNotBeEmpty;
          }
          return null;
        },
        onChanged: (value) {
          titleController.text = value;
        },
      ),
    );
  }

  String getDateOnly() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return formattedDate;
  }
}
