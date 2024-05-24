import 'package:floor/floor.dart';

//Example for Dao Inheritance
//You can extend an abstract class like this one without the @Dao annotation.
abstract class BaseDao<T> {
  @insert
  Future<void> insertItem(T item);

  @update
  Future<void> updateItem(T item);

  @delete
  Future<void> deleteItem(T item);
}
