import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/data/datasources/local/models/todo.dart';

import '../data/datasources/local/daos/todo.dao.dart';
import '../screens/todo_form_screen.dart';

class TodoFormPage extends ConsumerStatefulWidget {
  const TodoFormPage({super.key, required this.id});

  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoFormState();

  }

  class _TodoFormState extends ConsumerState<TodoFormPage> {
    @override
    void initState() {
      final todoForm = ref.read(todoFormProvider.notifier);
      todoForm.reset();
      todoForm.initialize(id: widget.id).then((value)
      {
        setState(() {});
      });
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
      final vm = ref.watch(todoFormProvider);

      print(vm.todo?.title);

      return AnimatedSwitcher(
        duration: const Duration(microseconds: 250),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: TodoFormScreen(todo: vm.todo, onEvent: (event) => _handleEvent(context, event)),
      );
  }

  void _handleEvent(BuildContext context, TodoFormScreenEvent event) {
    print('event name: ${event.name}');
  }
}

  class TodoFormViewModel {
    final Todo? todo;

    TodoFormViewModel({
      this.todo,
    });

    TodoFormViewModel copyWith({
      Todo? todo,
  }) {
      return TodoFormViewModel(
        todo: todo ?? this.todo,
      );
    }

  }

  class TodoFormViewModelNotifier extends Notifier<TodoFormViewModel> {
    @override
    build() {
      return TodoFormViewModel();
    }

    Future initialize({
      String? id,
  }) async {
      if (id!.isNotEmpty) {
        print('id: ${id}');
        Todo? cTodo = await TodoDao().getTodo(id: int.parse(id));

        state = state.copyWith(todo: cTodo);
      }
    }

    Future reset() async {
      Future(() =>
      state = state.copyWith(todo: Todo())
      );
    }
  }

  final todoFormProvider = NotifierProvider<TodoFormViewModelNotifier, TodoFormViewModel>(() => TodoFormViewModelNotifier());