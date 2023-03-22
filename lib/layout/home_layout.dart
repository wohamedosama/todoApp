import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/views/archived_tasks/archived_tasks.dart';
import 'package:to_do/views/done_tasks/done_tasks.dart';
import 'package:to_do/views/new_tasks/new_tasks.dart';
import 'package:to_do/widget/defualt%20_form_fileds.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  Database? database;

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
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          titles[currentIndex],
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ConditionalBuilder(
        condition: tasks.isNotEmpty,
        builder: (context) => screens[currentIndex],
        fallback: (context) => const Center(
            child: CircularProgressIndicator(
          color: Colors.blueAccent,
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              insetToDatabase(
                title: titleController.text,
                date: dateController.text,
                time: timeController.text,
              ).then((value) {
                getDateFromDatabase(database).then((value) {
                  Navigator.pop(context);

                  setState(() {
                    isBottomSheetShown = false;
                    fabIcon = Icons.add;
                    tasks = value;
                  });
                });
              });
            }
          } else {
            scaffoldKey.currentState!
                .showBottomSheet(
                  (context) {
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DefaultTextFormFields(
                              textEditingController: titleController,
                              type: TextInputType.text,
                              prefix: const Icon(Icons.title),
                              label: 'Task Title',
                            ),
                            const SizedBox(height: 15),
                            DefaultTextFormFields(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text =
                                      value!.format(context).toString();
                                });
                              },
                              textEditingController: timeController,
                              type: TextInputType.datetime,
                              prefix: const Icon(Icons.watch_later_outlined),
                              label: 'Task Time',
                            ),
                            const SizedBox(height: 15),
                            DefaultTextFormFields(
                                onTap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse('2050-12-31'))
                                      .then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                textEditingController: dateController,
                                type: TextInputType.datetime,
                                prefix:
                                    const Icon(Icons.calendar_month_outlined),
                                label: 'Date Tasks'),
                          ],
                        ),
                      ),
                    );
                  },
                  elevation: 15,
                )
                .closed
                .then((value) {
                  isBottomSheetShown = false;

                  setState(() {
                    fabIcon = (Icons.add);
                  });
                });
            isBottomSheetShown = true;

            setState(() {
              fabIcon = Icons.edit;
            });
          }
        },
        child: Icon(fabIcon),
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

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        try {
          print('database created');

          await database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
          print('table created');
        } catch (e) {
          print('error is ${e.toString()}');
        }
      },
      onOpen: (database) async {
        await getDateFromDatabase(database).then((value) {
          tasks = value;
        });
        print('database opened');
      },
    );
  }

  Future insetToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    return await database!.transaction((txn) async {
      try {
        txn.rawInsert(
          'INSERT INTO tasks(title ,date ,time ,status) VALUES("$title", "$date", "$time", "new")',
        );
        print('Inserted successfully');
      } catch (e) {
        print('error is ${e.toString()}');
      }
    });
  }

  Future<List<Map>> getDateFromDatabase(database) async {
    return await database!.rawQuery('SELECT * FROM tasks');
  }
}
