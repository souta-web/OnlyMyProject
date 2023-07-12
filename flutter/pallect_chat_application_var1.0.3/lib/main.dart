import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screen/chat/chat.dart';
import 'screen/timeline/timeline.dart';
import 'screen/data/data.dart';
import 'screen/setting/config.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
// 1. ConsumerWidget を継承したクラスを作成する
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // 2. 引数に WidgetRef ref を取るようにする
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. themModeProvider の ref オブジェクトを取得する
    final themeMode = ref.watch(themeModeProvider.state);
    return MaterialApp(
      debugShowCheckedModeBanner: false,//右上のデバッグ表示の設定
      title: 'Chat App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // 4. themeModeProvider の state を用いて themeMode を設定する
      themeMode: themeMode.state,
      home: MainScreen(),
      routes: {//遷移先追加するならここに追加
        '/main': (BuildContext context) => new MainScreen(),
        '/config': (BuildContext context) => new ConfigScreenWidget(),
        '/chat': (BuildContext context) => new ChatScreenWidget(),
        '/timelime': (BuildContext context) => new TimelineScreenWidget(),
        '/data': (BuildContext context) => new DataScreenWidget(),
      },
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


