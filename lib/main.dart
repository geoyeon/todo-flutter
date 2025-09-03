import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/app.dart';
import 'package:todo_flutter/data/datasources/local/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IsarDatabase.connect();

  return runApp(
    const ProviderScope(
      child: App(),
    )
  );
}