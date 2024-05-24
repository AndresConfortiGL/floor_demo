import 'package:flutter/material.dart';

import 'src/db/database.dart';
import 'src/db/task_dao.dart';
import 'src/view/task_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DATABASE INSTANCE
  final database = await $FloorFlutterDatabase
      .databaseBuilder('flutter_database.db')
      .build();

  // DAO
  final dao = database.taskDao;

  runApp(FloorApp(dao: dao));
}

class FloorApp extends StatelessWidget {
  final TaskDao dao;
  const FloorApp({super.key, required this.dao});

  static const String title = 'FLOOR DEMO APP';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: TasksWidget(
        title: title,
        dao: dao,
      ),
    );
  }
}
