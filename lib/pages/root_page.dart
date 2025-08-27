import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/widgets/navigation_bar/navigation_bar.dart';

class RootPageWithNavigation extends StatelessWidget {
  const RootPageWithNavigation({
    Key? key,
    required this.navigationShell,
}) : super(key: key ?? const ValueKey('RootPageWithNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: TodoNavigationBar(
        initialIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      ),
    );
  }
}