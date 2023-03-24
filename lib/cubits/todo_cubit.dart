import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}
