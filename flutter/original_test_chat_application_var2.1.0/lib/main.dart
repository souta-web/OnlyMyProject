import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chatpage.dart';
import 'actionlistpage.dart';
import 'actiondetailpage.dart';
import 'actioneditpage.dart';
import 'graphpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.light(),
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
    OptionPage(),
    GraphPage(),
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
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'TodoList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: 'Graph',
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
  List<String> items = ['チャット１', 'チャット２', 'チャット３'];

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

class OptionPage extends StatefulWidget {
  @override
  _OptionPage createState() => _OptionPage();
}

class _OptionPage extends State<OptionPage> {
  final List<bool> switchValues = [false]; // ダミーデータ
  final List<String> switchTexts = ['ダークモードをオンにする'];
  late bool isDarkMode;

  ThemeData getTheme() {
    return isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  void initstate(){
    super.initState();
    isDarkMode = switchValues[0];
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: switchValues.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(switchTexts[index]),
            trailing: Switch(
              value: switchValues[index],
              onChanged: (value) {
                // スイッチの値が変更されたときの処理
                // リストの対応する位置の値を更新する
                setState(() {
                  switchValues[index] = value;
                  toggleDarkMode(value);
                });
              },
            ),
          );
        },
      ),
    );
  }
}