import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';
import 'chatpage.dart';
import 'actionlistpage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAppHome(),
    );
  }
}

class MyAppHome extends StatefulWidget {
  
  @override
  _MyAppHome createState() => _MyAppHome();
}

class _MyAppHome extends State<MyAppHome> {
  // ここにウィジェットの状態を保持する変数やメソッドを追加します
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ActionListPage(),
    NavigationChatPage(),
    Page3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Page 3',
          ),
        ],
      ),
    );
  }
}

class NavigationChatPage extends StatefulWidget {
  @override
  _NavigationChatPage createState() => _NavigationChatPage();
}

class _NavigationChatPage extends State<NavigationChatPage> {
  var chatscreen = ChatScreen();
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // 画面遷移の処理を実装する
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => chatscreen,
                ),
              );
            },
            child: ListTile(
              title: Text(items[index]),
            ),
          );
        },
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text('Page 3'),
      ),
    );
  }
}