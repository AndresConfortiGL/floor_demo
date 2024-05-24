import 'package:flutter/material.dart';

import '../../db/task_dao.dart';
import '../../db/task_entity.dart';
import '../../utils/enums.dart';
import 'task_listitem.dart';

class TasksListView extends StatelessWidget {
  final TaskDao dao;
  final TaskStatus? selectedType;

  const TasksListView({
    super.key,
    required this.dao,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Task>>(
        stream: selectedType == null
            ? dao.findAllTasksAsStream()
            : dao.findAllTasksByStatusAsStream(selectedType!),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return Container();

          final tasks = snapshot.requireData;

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, index) {
              return TaskListCell(
                task: tasks[index],
                dao: dao,
              );
            },
          );
        },
      ),
    );
  }
}
