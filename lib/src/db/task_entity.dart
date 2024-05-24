import 'package:floor/floor.dart';

import '../utils/enums.dart';

//REPRESENTS THE DATABASE TABLE.
@entity
class Task {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String message;
  final bool? isRead;
  final DateTime timestamp;
  final TaskStatus? status;
  final TaskType? type;

  Task(
    this.id,
    this.isRead,
    this.message,
    this.timestamp,
    this.status,
    this.type,
  );

  factory Task.optional({
    int? id,
    DateTime? timestamp,
    String? message,
    bool? isRead,
    TaskStatus? status,
    TaskType? type,
  }) =>
      Task(
        id,
        isRead ?? false,
        message ?? 'empty',
        timestamp ?? DateTime.now(),
        status,
        type,
      );

  Task copyWith({
    int? id,
    String? message,
    bool? isRead,
    DateTime? timestamp,
    TaskStatus? status,
    TaskType? type,
  }) {
    return Task(
      id ?? this.id,
      isRead ?? this.isRead,
      message ?? this.message,
      timestamp ?? this.timestamp,
      status ?? this.status,
      type ?? this.type,
    );
  }

  String get statusTitle => status?.title ?? 'Empty';

  int get statusIndex => status?.index ?? 0;
}
