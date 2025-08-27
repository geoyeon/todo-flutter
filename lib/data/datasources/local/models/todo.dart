import 'package:isar/isar.dart';

part 'todo.g.dart';

@Collection()
class Todo {
  Id id = Isar.autoIncrement;
  @Index()
  String title = '';
  @Index()
  String? memo = null;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(hours: 1));
  @Index()
  bool isComplete = false;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}
