import 'package:flutter/material.dart';
import 'chat.dart';
import 'timeline.dart';
import 'data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> _screens = [
    ChatScreenWidget(),
    TimelineScreenWidget(),
    DataScreenWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            //icon: Icon(Icons.chat),
            icon: Image.asset('assets/images/chat_icon.png',width: 30,height: 30,), // オリジナルのアイコン画像を指定
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            //icon: Icon(Icons.timeline),
            icon: Image.asset('assets/images/timeline_icon.png',width: 30,height: 30,), // オリジナルのアイコン画像を指定
            label: 'Timeline',
          ),
          BottomNavigationBarItem(
            //icon: Icon(Icons.data_usage),
            icon: Image.asset('assets/images/data_icon.png',width: 30,height: 30,), // オリジナルのアイコン画像を指定
            label: 'Data',
          ),
        ],
      ),
    );
  }
}
