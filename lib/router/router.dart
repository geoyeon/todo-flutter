import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/pages/TodoFormPage.dart';
import 'package:todo_flutter/pages/root_page.dart';
import 'package:todo_flutter/pages/tabs/home_page.dart';
import 'package:todo_flutter/router/todo_routes.dart';

import '../screens/todo_form_screen.dart';

part '_branches.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerConfig = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, navigationShell) => RootPageWithNavigation(
          navigationShell: navigationShell,
        ),
        branches: _branches),
    GoRoute(path: TodoRoute.homeTab.path, name: TodoRoute.homeTab.name, builder: (context, state) => HomePage(), routes: [
      GoRoute(parentNavigatorKey: _rootNavigatorKey, path: TodoRoute.todoModifyForm.path, name: TodoRoute.todoModifyForm.name, routes: const <GoRoute>[], builder: (context, state) {
        final String? id = state.pathParameters['id'];
        return TodoFormPage(id: id!);
      }),
      GoRoute(parentNavigatorKey: _rootNavigatorKey, path: TodoRoute.todoWriteForm.path, name: TodoRoute.todoWriteForm.name, routes: const <GoRoute>[], builder: (context, state) => TodoFormPage(id: '')),
    ])
  ],
);