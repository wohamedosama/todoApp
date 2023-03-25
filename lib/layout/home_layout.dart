import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/cubits/todo_cubit.dart';
import 'package:to_do/widget/defualt%20_form_fileds.dart';

class HomeLayout extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  HomeLayout({super.key});

  // @override
  // void initState() {
  //   super.initState();
  //   createDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {
          if (state is TodoInsertDataBase) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          TodoCubit todoCubit = TodoCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                todoCubit.titles[todoCubit.currentIndex],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! TodoGetDataBaseLoadingState,
              builder: (context) => todoCubit.screens[todoCubit.currentIndex],
              fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                color: Colors.blueAccent,
              )),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (todoCubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    todoCubit.insetToDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );
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
                                    prefix:
                                        const Icon(Icons.watch_later_outlined),
                                    label: 'Task Time',
                                  ),
                                  const SizedBox(height: 15),
                                  DefaultTextFormFields(
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2050-12-31'))
                                            .then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);
                                        });
                                      },
                                      textEditingController: dateController,
                                      type: TextInputType.datetime,
                                      prefix: const Icon(
                                          Icons.calendar_month_outlined),
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
                        todoCubit.changeBottomSheet(
                          icons: Icons.add,
                          isShow: false,
                        );
                      });
                  todoCubit.changeBottomSheet(
                    icons: Icons.edit,
                    isShow: true,
                  );
                }
              },
              child: Icon(todoCubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: todoCubit.currentIndex,
              onTap: (index) {
                todoCubit.changeIndex(index);
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
        },
      ),
    );
  }
}
