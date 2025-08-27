import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/data/datasources/local/daos/todo.dao.dart';
import 'package:todo_flutter/data/datasources/local/models/todo.dart';
import 'package:todo_flutter/screens/home_screen.dart';

import '../../screens/todo_list_screen.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool locationGranted = false;
  bool initialized = false;

  @override
  void initState() {
    print('start');
    final home = ref.read(homeProvider.notifier);
    home.initialize();
    setState(() {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(homeProvider);

    return AnimatedSwitcher(
      duration: const Duration(microseconds: 250),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: TodoListScreen(todos: vm.todos, onEvent: (event) => _handleEvent(context, event)),
    );
  }

  void _handleEvent(BuildContext context, HomeScreenEvent event) {
    final provider = ref.read(homeProvider.notifier);
    final vm = ref.read(homeProvider);

    print('event name: ${event.name}');

    if (event.name == 'reload_todos') {
      provider.initialize();
    }
  }
}

class HomePageViewModel {
  final List<Todo> todos;

  HomePageViewModel({
    this.todos = const [],
  });

  HomePageViewModel copyWith({
    List<Todo>? todos,
}) {
    return HomePageViewModel(
      todos: todos ?? this.todos,
    );
  }
}

class HomePageViewModelNotifier extends Notifier<HomePageViewModel> {
  @override
  build() {
    return HomePageViewModel();
  }

  Future initialize() {
    return TodoDao().getTodos().then((list) {
      print(list);
      final List<Todo>? todos = list;

      state = state.copyWith(todos: todos);
    });
  }

  getTodos() {
    print('getTodos');
    return TodoDao().getTodos();
  }
}

final homeProvider = NotifierProvider<HomePageViewModelNotifier, HomePageViewModel>(() => HomePageViewModelNotifier());