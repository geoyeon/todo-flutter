enum TodoRoute {
  homeTab(name: 'home', path: '/home'),
  todoModifyForm(name: 'todoModifyForm',path: 'modify/:id'),
  todoWriteForm(name: 'todoWriteForm', path: 'create');


  const TodoRoute({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;

  @override
  String toString() => path;
}