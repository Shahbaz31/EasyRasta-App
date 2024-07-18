import 'package:flutter/material.dart';
import 'package:map_application/GoogleMap/G_Map.dart';

import 'package:map_application/RouteSelector.dart';
import 'package:map_application/mapscreen.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('EasyRasta'),
        centerTitle: false,
      ),
      body: _getPage(_currentIndex),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _handleNavigation(index);
        },
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return G_map();
      case 1:
        return selectroutes();
      default:
        return Container(); // Handle other cases if needed
    }
  }

  void _handleNavigation(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  MyBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.navigation_sharp),
          label: 'Route Selection',
        ),
      ],
    );
  }
}
