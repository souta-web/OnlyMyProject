import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';//日本語化

import 'screen/chat/chat_screen.dart';
import 'screen/timeline/timeline_screen.dart';
import 'screen/data/data_screen.dart';
import 'screen/setting/config_screen.dart';

void main() {
  initializeDateFormatting().then((_) =>runApp(const ProviderScope(child: MyApp())));//initializeDateFormatting().then((_) => は日本語化に使用しています
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider.state);
    return MaterialApp(
      debugShowCheckedModeBanner: false,//右上のデバッグ表示を消す（最終版には必要ない）
      title: 'Chat App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode.state,
      home: MainScreen(),
      routes: {
        '/main': (BuildContext context) => MainScreen(),
        '/config': (BuildContext context) => ConfigScreenWidget(),
        '/chat': (BuildContext context) => ChatScreenWidget(),
        '/timeline': (BuildContext context) => TimelineScreenWidget(),
        '/data': (BuildContext context) => DataScreenWidget(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Image.asset('assets/images/chat_icon.png', width: 30, height: 30),
      activeIcon: Image.asset('assets/images/chat_icon_d.png', width: 30, height: 30),
      label: 'Chat',
    ),
    BottomNavigationBarItem(
      icon: Image.asset('assets/images/timeline_icon.png', width: 30, height: 30),
      activeIcon: Image.asset('assets/images/timeline_icon_d.png', width: 30, height: 30),
      label: 'Timeline',
    ),
    BottomNavigationBarItem(
      icon: Image.asset('assets/images/data_icon.png', width: 30, height: 30),
      activeIcon: Image.asset('assets/images/data_icon_d.png', width: 30, height: 30),
      label: 'Data',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _screens = [
    ChatScreenWidget(),
    TimelineScreenWidget(),
    DataScreenWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: _bottomNavBarItems,
        selectedItemColor: Color(0xFFFF9515), // カラーコードで指定します (例: 青色)
      ),
    );
  }
}
