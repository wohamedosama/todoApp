import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/views/archived_tasks/archived_tasks.dart';
import 'package:to_do/views/done_tasks/done_tasks.dart';

import '../views/new_tasks/new_tasks.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  static TodoCubit get(context) => BlocProvider.of(context);
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

  void changeIndex(int index) {
    currentIndex = index;
    emit(TodoChangeBottomNavBar());
  }

  Database? database;
  List<Map> tasks = [];

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((e) {
        print('Error  When Creating is  ${e.toString()}');
      });
    }, onOpen: (database) {
      getDateFromDatabase(database).then((value) {
        tasks = value;
        emit(TodoGetDataBase());
      });
    }).then((value) {
      database = value;
      emit(TodoCreateDataBase());
    });
  }

  insetToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database!.transaction((txn) async {
      try {
        txn.rawInsert(
          'INSERT INTO tasks(title ,date ,time ,status) VALUES("$title", "$date", "$time", "new")',
        );
        print('Inserted successfully');
        emit(TodoInsertDataBase());
        getDateFromDatabase(database).then((value) {
          tasks = value;
          emit(TodoGetDataBase());
        });
      } catch (e) {
        print('error is ${e.toString()}');
      }
    });
  }

  Future<List<Map>> getDateFromDatabase(database) async {
    emit(TodoGetDataBaseLoadingState());
    return await database!.rawQuery('SELECT * FROM tasks');
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet({
    required IconData icons,
    required bool isShow,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icons;
    emit(TodoChangeDateBase());
  }
}
