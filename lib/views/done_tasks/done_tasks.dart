import 'package:flutter/material.dart';

class DoneTasksScreens extends StatelessWidget {
  const DoneTasksScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Done Tasks',
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
