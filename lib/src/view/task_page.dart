import 'package:flutter/material.dart';

import '../db/task_dao.dart';
import '../utils/enums.dart';
import 'widgets/task_listview.dart';
import 'widgets/task_textfield.dart';

class TasksWidget extends StatefulWidget {
  final String title;
  final TaskDao dao;

  const TasksWidget({
    super.key,
    required this.title,
    required this.dao,
  });

  @override
  State<StatefulWidget> createState() => TasksWidgetState();
}

class TasksWidgetState extends State<TasksWidget> {
  TaskStatus? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(widget.title),
        centerTitle: true,
        leading: Align(
          alignment: Alignment.center,
          child: StreamBuilder(
              // Displays a counter with how many task are saved.
              stream: widget.dao.findUniqueMessagesCountAsStream(),
              builder: (_, snapshot) => Text(' DATA: ${snapshot.data ?? 0}')),
        ),
        actions: menuButton(),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TasksListView(
              dao: widget.dao,
              selectedType: _selectedType,
            ),
            TasksTextField(dao: widget.dao),
          ],
        ),
      ),
    );
  }

  // Displays a counter with how many task are saved.
  List<Widget> menuButton() {
    return <Widget>[
      PopupMenuButton<int>(
        itemBuilder: (context) {
          return List.generate(
            TaskStatus.values.length + 1, //Uses increment to handle All types
            (index) {
              return PopupMenuItem<int>(
                value: index,
                child: Text(
                  index == 0 ? 'All' : _getMenuType(index).title,
                ),
              );
            },
          );
        },
        onSelected: (index) {
          setState(() {
            _selectedType = index == 0 ? null : _getMenuType(index);
          });
        },
      )
    ];
  }

  TaskStatus _getMenuType(int index) => TaskStatus.values[index - 1];
}
