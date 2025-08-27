part of 'router.dart';

typedef _TabRoute = (String, String, Widget);
typedef _TabRouteSetting = List<_TabRoute>;

final _TabRouteSetting _settings = <_TabRoute>[
  ('HomeTab', '/home', const HomePage()),
  ('MyTab', '/my', const HomePage()),
];

final _branches = _settings.map<StatefulShellBranch>(_buildStatefulShellBranch).toList();

StatefulShellBranch _buildStatefulShellBranch(_TabRoute route) {
  return StatefulShellBranch(
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: route.$1),
  routes: [
    GoRoute(path: route.$2, pageBuilder: (context, state) => NoTransitionPage(child: route.$3), routes: const []),
  ],
  );
}