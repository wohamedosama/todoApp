import 'package:flutter/material.dart';

class ArchivedTasksScreens extends StatelessWidget {
  const ArchivedTasksScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Archived Tasks',
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
