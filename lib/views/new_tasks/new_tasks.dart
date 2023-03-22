import 'package:flutter/material.dart';

class NewTasksScreens extends StatelessWidget {
  const NewTasksScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'New Tasks',
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
