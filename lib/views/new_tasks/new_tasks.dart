import 'package:flutter/material.dart';
import 'package:to_do/components/build_task_item.dart';
import 'package:to_do/constants.dart';

class NewTasksScreens extends StatelessWidget {
  const NewTasksScreens({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return BuildTaskItem(
          model: tasks[index],
        );
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20,
            end: 20,
          ),
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[400],
          ),
        );
      },
      itemCount: tasks.length,
    );
  }
}
