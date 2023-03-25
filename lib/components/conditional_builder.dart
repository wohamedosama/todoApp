import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:to_do/components/build_task_item.dart';

class ConditionalBuilderItem extends StatelessWidget {
  const ConditionalBuilderItem({
    Key? key,
    required this.tasks,
  }) : super(key: key);
  final List<Map> tasks;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (BuildContext context) {
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
      },
      fallback: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.menu,
                size: 80,
                color: Colors.grey,
              ),
              Text(
                'No Tasks Yet Please Add Some Tasks',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
