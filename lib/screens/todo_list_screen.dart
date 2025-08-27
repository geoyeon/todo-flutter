import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/pages/tabs/home_page.dart';
import 'package:todo_flutter/screens/home_screen.dart';
import 'package:todo_flutter/screens/todo_form_screen.dart';

import '../data/datasources/local/daos/todo.dao.dart';
import '../data/datasources/local/models/todo.dart';

class TodoListScreenEvent extends ScreenEvent {
  final dynamic value;

  TodoListScreenEvent({
    String screen = 'TodoListScreen',
    required super.name,
    this.value
}) : super(screen: screen);
}

class TodoListScreen extends StatelessWidget {
  final ValueChanged<HomeScreenEvent> onEvent;

  final List<Todo> todos;

  const TodoListScreen({super.key, required this.todos, required this.onEvent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 목록'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_card),
            onPressed: () async {
              final result = await context.push('./create');
              if (result != null) {
                onEvent(HomeScreenEvent(name: 'reload_todos'));
              }
              return;
            })
    ],
      ),
      body: todos.isEmpty
          ? const Center(
        child: Text('Todo가 없습니다.'),
      )
          : ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return TodoCard(todo: todo, onEvent: onEvent);
        },
      ),
    );
  }
}

// 개별 Todo 항목을 카드 형태로 보여주는 위젯
class TodoCard extends StatelessWidget {
  final Todo todo;
  final ValueChanged<HomeScreenEvent> onEvent;

  const TodoCard({super.key, required this.todo, required this.onEvent});

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)} '
        '${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}';
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            todo.memo!.isNotEmpty ? Container(
              width: double.infinity,
              child: Card(
                color: Colors.white54,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
                child: Text(todo.memo ?? ''),
              ),
              ),
            ) : SizedBox.shrink(),

            todo.memo!.isNotEmpty ? const SizedBox(height: 8) : SizedBox.shrink(),
            Text(
              '시작: ${_formatDateTime(todo.startDate)}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              '종료: ${_formatDateTime(todo.endDate)}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        )
            ),
            SizedBox(width: 100, child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                child: Text('수정'),
                onPressed: () async {
                  final result = await context.push('./modify/${todo.id}');
                  print('result : ${result}');
                  if (result == 'refresh') {
                    onEvent(HomeScreenEvent(name: 'reload_todos'));
                  }
                },
                style: TextButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
              ),
              SizedBox(height: 8),
              TextButton(
                child: Text('삭제'),
                onPressed: () async {
                  await TodoDao().delTodo(id: todo.id);
                  onEvent(HomeScreenEvent(name: 'reload_todos'));
                },
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
              )
            ]
          ))],
      ),
      ),
    );
  }
}