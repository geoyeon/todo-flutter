import 'package:flutter/material.dart';

abstract class ScreenEvent {
  final String screen;
  final String name;

  ScreenEvent({
    required this.screen,
    required this.name,
  });
}

class HomeScreenEvent extends ScreenEvent {
  final dynamic value;

  HomeScreenEvent({
    String screen = 'HomeScreen',
    required super.name,
    this.value
}) : super(screen: screen);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text('HomeScreen'),
    );
  }
}