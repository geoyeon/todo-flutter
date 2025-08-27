import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_flutter/data/datasources/local/models/todo.dart';

class IsarDatabase {
  static Future<Isar> connect() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return Isar.open(
        [TodoSchema],
        inspector: true,
        directory: dir.path,
      ).then((value) => value);
    }

    return Isar.getInstance()!;
  }
}