import 'package:flutter/material.dart';
import 'package:to_do/views/archived_tasks/archived_tasks.dart';
import 'package:to_do/views/done_tasks/done_tasks.dart';
import 'package:to_do/views/new_tasks/new_tasks.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = const [
    NewTasksScreens(),
    DoneTasksScreens(),
    ArchivedTasksScreens(),
  ];
  List<String> titles = const [
    'New  Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          titles[currentIndex],
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            print(await getName());
          } catch (e) {
            print('error is ${e.toString()}');
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'Archived',
          ),
        ],
      ),
    );
  }

  Future<String> getName() async {
    return 'Ahmed Ali';
  }
}
