import 'package:flutter/material.dart';
import 'package:flutter_project_group4/screens/myaccount.dart';
import 'package:flutter_project_group4/screens/trending.dart';
import 'screens/news.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      home: BottomNavigationProject(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class BottomNavigationProject extends StatefulWidget {
  const BottomNavigationProject({super.key});
  @override
  State<BottomNavigationProject> createState() => _BottomNavigationProject();
}

class _BottomNavigationProject extends State<BottomNavigationProject> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    NewsScreen(),
    TrendingScreen(),
    MyAccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Tin tức'),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Xu hướng',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
