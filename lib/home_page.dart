import 'package:flutter/material.dart';
import 'package:activity_tracker/components/habit_tile.dart';
import 'package:activity_tracker/components/new_habit_box.dart';
import 'components/my_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todayHabitList = [
    ["Morning Run", false],
    ["Evening Game", false],
  ];

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todayHabitList[index][1] = value;
    });
  }

  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return EnterNewHabitBox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelNewHabit,
        );
      },
    );
  }

  void saveNewHabit() {
    setState(() {
      todayHabitList.add([_newHabitNameController.text, false]);
    });
    _newHabitNameController.clear();

    Navigator.of(context).pop();
  }

// New change
  void cancelNewHabit() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: MyFloatingActionButton(
          onPressed: createNewHabit,
        ),
        backgroundColor: Colors.grey[300],
        body: ListView.builder(
            itemCount: todayHabitList.length,
            itemBuilder: ((context, index) {
              return HabitTile(
                habitName: todayHabitList[index][0],
                habitCompleted: todayHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
              );
            })));
  }
}
