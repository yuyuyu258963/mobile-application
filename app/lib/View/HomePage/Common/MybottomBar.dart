import 'package:flutter/material.dart';

const List<NavigationDestination> navigationList = [
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.widgets_outlined),
    label: "菜单",
    selectedIcon: Icon(Icons.widgets),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.file_open_outlined),
    label: "发现",
    selectedIcon: Icon(Icons.file_open),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.text_fields),
    label: "列表",
    selectedIcon: Icon(Icons.text_fields_outlined),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.people_alt_outlined),
    label: "我的",
    selectedIcon: Icon(Icons.people),
  )
];


class MyBottomNavBar extends StatefulWidget {
  MyBottomNavBar({super.key, this.fn });
  late Function(int v)? fn;

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _currentIndex = 0;

  void selectHandler(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: navigationList,
      selectedIndex: _currentIndex,
      onDestinationSelected: selectHandler,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.red,
    );
  }
}


