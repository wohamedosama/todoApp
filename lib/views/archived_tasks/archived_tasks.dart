import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/components/build_task_item.dart';
import 'package:to_do/cubits/todo_cubit.dart';

import '../../components/conditional_builder.dart';

class ArchivedTasksScreens extends StatelessWidget {
  const ArchivedTasksScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TodoCubit.get(context).archivedTasks;
        return ConditionalBuilderItem(
          tasks: tasks,
        );
      },
    );
  }
}
