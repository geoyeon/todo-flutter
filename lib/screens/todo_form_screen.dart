import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/data/datasources/local/daos/todo.dao.dart';
import 'package:todo_flutter/screens/home_screen.dart';

import '../data/datasources/local/models/todo.dart';

class TodoFormScreenEvent extends ScreenEvent {
  final dynamic value;

  TodoFormScreenEvent({
    String screen = 'TodoFormScreen',
    required super.name,
    this.value
}) : super(screen: screen);
}

class TodoFormScreen extends StatefulWidget {
  final ValueChanged<TodoFormScreenEvent> onEvent;
  final Todo? todo;

  const TodoFormScreen({super.key, this.todo, required this.onEvent});

  @override
  State<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();

  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now().add(const Duration(hours: 1));

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.todo?.title ?? '';
    _memoController.text = widget.todo?.memo ?? '';
    _startDateTime = widget.todo?.startDate ?? DateTime.now();
    _endDateTime = widget.todo?.endDate ?? DateTime.now().add(const Duration(hours: 1));
  }

  @override
  void dispose() {
    print('dispose');
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  // 날짜 선택기
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDateTime : _endDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (isStart) {
        setState(() {
          _startDateTime = picked;
        });
      } else {
        setState(() {
          _endDateTime = picked;
        });
      }
    }
  }

  // 시간 선택기
  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(isStart ? _startDateTime : _endDateTime),
    );

    if (picked != null) {
      if (isStart) {
        setState(() {
          _startDateTime = DateTime(
            _startDateTime.year,
            _startDateTime.month,
            _startDateTime.day,
            picked.hour,
            picked.minute,
          );
        });
      } else {
        setState(() {
          _endDateTime = DateTime(
            _endDateTime.year,
            _endDateTime.month,
            _endDateTime.day,
            picked.hour,
            picked.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 작성'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              // TODO: 데이터 저장 로직 구현
              print('Title: ${_titleController.text}');
              print('Memo: ${_memoController.text}');
              print('Start: $_startDateTime');
              print('End: $_endDateTime');
              // Navigator.of(context).pop();

              if (_titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('제목을 입력하세요')),
                );
                return;
              }


              Todo todo = widget.todo == null ? Todo() : widget.todo!;
              todo.title = _titleController.text;
              todo.memo = _memoController.text;
              todo.startDate = _startDateTime;
              todo.endDate = _endDateTime;
              todo.createdAt = DateTime.now();
              todo.updatedAt = DateTime.now();

              TodoDao todoDao = TodoDao();

              await todoDao.addTodo(todo)
              .then((result) {
                print(result);
                context.pop('refresh');
              })
              .catchError((error) => print(error));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('제목', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Todo 제목을 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('메모', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextFormField(
              controller: _memoController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: '상세 내용을 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('시작 일시', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ListTile(
              title: Text(
                '${_startDateTime.year}-${_startDateTime.month.toString().padLeft(2, '0')}-${_startDateTime.day.toString().padLeft(2, '0')} '
                    '${_startDateTime.hour.toString().padLeft(2, '0')}:${_startDateTime.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                await _selectDate(context, true);
                if (!mounted) return;
                await _selectTime(context, true);
              },
            ),
            const SizedBox(height: 20),
            const Text('종료 일시', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ListTile(
              title: Text(
                '${_endDateTime.year}-${_endDateTime.month.toString().padLeft(2, '0')}-${_endDateTime.day.toString().padLeft(2, '0')} '
                    '${_endDateTime.hour.toString().padLeft(2, '0')}:${_endDateTime.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                await _selectDate(context, false);
                if (!mounted) return;
                await _selectTime(context, false);
              },
            ),
          ],
        ),
      ),
    );
  }
}