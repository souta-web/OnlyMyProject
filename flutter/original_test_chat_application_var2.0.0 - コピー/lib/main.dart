import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';
import 'chatpage.dart';
import 'actionlistpage.dart';
import 'actiondetailpage.dart';
import 'actioneditpage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {//画面遷移で任意のページに移動するための初期設定
        '/': (context) => MyAppHome(),
      },
      onGenerateRoute: (settings) {//ActionDetailPageに移動するための初期設定
        if (settings.name == '/actionDetailPage') {//Navigator.PushNamedで/actionDetailPageを指定すると移動できる
          // 引数を指定して新しい画面に遷移
          final args = settings.arguments as Map<String, dynamic>;
          print('/actionDetailPage'+args['choice_record'].toString());
          return MaterialPageRoute(
            builder: (context) => ActionDetailPage(action_table_alldata_detailpage:args['choice_record']),
          );
        } else if (settings.name == '/actionEditPage'){
          // 引数を指定して新しい画面に遷移
          final args = settings.arguments as Map<String, dynamic>;
          print('/actionEditPage'+args['choice_record'].toString());
          return MaterialPageRoute(
            builder: (context) => ActionEditPage(action_table_alldata_editpage:args['choice_record']),
          );
        }
        return null;
      },
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