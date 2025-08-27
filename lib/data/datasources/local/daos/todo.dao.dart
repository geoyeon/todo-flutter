import 'package:isar/isar.dart';
import 'package:todo_flutter/data/datasources/local/app_database.dart';
import 'package:todo_flutter/data/datasources/local/models/todo.dart';

class TodoDao {
  late Isar? db;

  TodoDao() {
    db = Isar.getInstance();
  }

  Future<int?> addTodo(Todo todo) async {
    return await db?.writeTxn(() async {
      return await db?.todos.put(todo);
    });
  }

  Future<List<Todo>?> getTodos() async {
    return await db?.todos.where(sort: Sort.desc).anyId().findAll();
  }

  Future<Todo?> getTodo({id}) async {
    return await db?.todos.get(id);
  }

  Future<bool?> delTodo({id}) async {
    return await db?.writeTxn(() async {
      return await db?.todos.delete(id);
    });
  }

  Future<void> updateTodo(Todo todo) async {
    await db?.writeTxn(() async {
      return await db?.todos.put(todo);
    });
  }
}