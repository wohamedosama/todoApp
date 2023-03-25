import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/components/build_task_item.dart';
import 'package:to_do/components/conditional_builder.dart';
import 'package:to_do/cubits/todo_cubit.dart';

class NewTasksScreens extends StatelessWidget {
  const NewTasksScreens({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TodoCubit.get(context).newTasks;
        return ConditionalBuilderItem(
          tasks: tasks,
        );
      },
    );
  }
}
