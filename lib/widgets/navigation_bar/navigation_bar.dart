import 'package:flutter/material.dart';

typedef NavigationData = ({
  String label, Icon icon, Icon selectedIcon
});

class TodoNavigationBar extends StatefulWidget {
  const TodoNavigationBar({
    super.key,
    required this.onDestinationSelected,
    required this.initialIndex,
    this.destinations = const <NavigationData> [],
});

  final ValueChanged<int> onDestinationSelected;
  final int initialIndex;
  final List<NavigationData>? destinations;

  List<NavigationData> get defaultTabData => [
    (
      label: '홈',
      icon: const Icon(Icons.home_outlined),
      selectedIcon: const Icon(Icons.home),
    ),
    (
    label: '내 정보',
    icon: const Icon(Icons.info_outline),
    selectedIcon: const Icon(Icons.info),
    ),
  ];

  @override
  State<TodoNavigationBar> createState() => _TodoNavigationBarState();
}

class _TodoNavigationBarState extends State<TodoNavigationBar> {
  late int selectedIndex;
  late List<NavigationData> destinations;

  bool get isDestinationsEmpty => widget.destinations == null || widget.destinations!.isEmpty;

  @override
  void initState() {
    selectedIndex = widget.initialIndex;
    destinations = isDestinationsEmpty ? widget.defaultTabData : widget.destinations!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      elevation: 0,
      enableFeedback: true,
      onTap: (index) {
        selectedIndex = index;
        setState(() {});
        widget.onDestinationSelected.call(index);
      },
      selectedLabelStyle: const TextStyle(color: Colors.black),
      unselectedLabelStyle: const TextStyle(color: Colors.black),
      items: destinations.map((data) {
        return BottomNavigationBarItem(icon: data.icon, label: data.label);
      }).toList(),
    );
  }
}

class _TodoNavigationBarItem extends StatelessWidget {
  const _TodoNavigationBarItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
  }) : super(key: key);

  final bool selected;
  final VoidCallback onTap;
  final Widget icon;
  final Widget selectedIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final currentIcon = selected ? selectedIcon : icon;
    final padding = const EdgeInsets.symmetric(
      horizontal: 11,
      vertical: 8,
    );
    final labelStyle = const TextStyle(
      fontSize: 11.2,
      fontWeight: FontWeight.w500,
      color: Color(0xFF6C7582),
    );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
          padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          currentIcon,
          Text(label, style: labelStyle),
        ],
      ),),
    );
  }
}