import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../db/task_dao.dart';
import '../../db/task_entity.dart';
import '../../utils/enums.dart';

class TaskListCell extends StatelessWidget {
  final Task task;
  final TaskDao dao;

  const TaskListCell({
    super.key,
    required this.task,
    required this.dao,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${task.hashCode}'),
      background: Container(
        padding: const EdgeInsets.only(left: 16),
        color: Colors.green,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Change status',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      direction: DismissDirection.horizontal,
      child: ListTile(
        title: Text(task.message),
        subtitle: Text('Status: ${task.statusTitle}'),
        trailing: Text(convertedTime(task.timestamp)),
      ),
      confirmDismiss: (direction) async {
        String? statusMessage;
        switch (direction) {
          case DismissDirection.endToStart:
            await dao.deleteTask(task);
            statusMessage = 'Removed task';
            break;
          case DismissDirection.startToEnd:
            final tasksLength = TaskStatus.values.length;
            final nextIndex =
                (tasksLength + task.statusIndex + 1) % tasksLength;
            final taskCopy =
                task.copyWith(status: TaskStatus.values[nextIndex]);
            await dao.updateTask(taskCopy);
            statusMessage = 'Updated task status by: ${taskCopy.statusTitle}';
            break;
          default:
            break;
        }

        if (statusMessage != null && context.mounted) {
          final scaffoldMessengerState = ScaffoldMessenger.of(context);
          scaffoldMessengerState.hideCurrentSnackBar();
          scaffoldMessengerState.showSnackBar(
            SnackBar(content: Text(statusMessage)),
          );
        }
        return statusMessage != null;
      },
    );
  }

  String convertedTime(DateTime time) {
    DateFormat formatedDate = DateFormat('dd-MM-yyyy - HH:mm:ss');
    return formatedDate.format(time).toString();
  }
}
