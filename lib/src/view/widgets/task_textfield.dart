import 'package:flutter/material.dart';

import '../../db/task_dao.dart';
import '../../db/task_entity.dart';
import '../../utils/enums.dart';

class TasksTextField extends StatelessWidget {
  final TextEditingController _textEditingController;
  final TaskDao dao;

  TasksTextField({
    super.key,
    required this.dao,
  }) : _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
                hintText: 'Write a task here...',
                hintStyle: TextStyle(color: Colors.black),
              ),
              onSubmitted: (_) async {
                await _persistMessage();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              style: const ButtonStyle(),
              onPressed: () async {
                await _persistMessage();
              },
              child: const Text(
                'Add Task',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _persistMessage() async {
    final message = _textEditingController.text;
    if (message.trim().isEmpty) {
      _textEditingController.clear();
    } else {
      final task = Task.optional(message: message, type: TaskType.task);
      await dao.insertTask(task);
      _textEditingController.clear();
    }
  }
}
