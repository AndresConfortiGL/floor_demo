import 'package:sqflite/sqflite.dart' as sqflite;

import '../utils/db_imports.dart';
import '../utils/enums.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Task])
@TypeConverters([DateTimeConverter, TaskTypeConverter])
abstract class FlutterDatabase extends FloorDatabase {
  TaskDao get taskDao;
}

/*
Run the generator with "flutter packages pub run build_runner build"

To automatically run it, whenever a file changes use:
"flutter packages pub run build_runner watch."
*/
