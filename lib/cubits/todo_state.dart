part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoChangeBottomNavBar extends TodoState {}

class TodoCreateDataBase extends TodoState {}

class TodoGetDataBase extends TodoState {}

class TodoGetDataBaseLoadingState extends TodoState {}

class TodoInsertDataBase extends TodoState {}

class TodoChangeDateBase extends TodoState {}
