import 'package:flutter/material.dart';
import 'package:to_do/cubits/todo_cubit.dart';

class BuildTaskItem extends StatelessWidget {
  const BuildTaskItem({Key? key, required this.model}) : super(key: key);
  final Map? model;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model!['id'].toString()),
      onDismissed: (direction) {
        TodoCubit.get(context).recordsDelete(id: model!['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                '${model!['time']}',
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model!['title']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${model!['date']}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    TodoCubit.get(context).recordsUpdate(
                      status: 'done',
                      id: model!['id'],
                    );
                  },
                  icon: Icon(
                    Icons.check_box,
                    color: Colors.green[600],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    TodoCubit.get(context).recordsUpdate(
                      status: 'archived',
                      id: model!['id'],
                    );
                  },
                  icon: Icon(
                    Icons.archive_sharp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
