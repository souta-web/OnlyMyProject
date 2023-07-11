import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'chat.dart';
import 'timeline.dart';
import 'data.dart';
import 'config.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
// アプリ全体の外観モードの状態を管理するプロバイダー
final themeModeProvider = StateProvider<ThemeMode>((ref)=>ThemeMode.system);//.system:システム設定に従う.light.dark:それぞれのモード

// 1. ConsumerWidget を継承したクラスを作成する
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // 2. 引数に WidgetRef ref を取るようにする
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. themModeProvider の ref オブジェクトを取得する
    // デフォルトはシステム設定に従う(ThemeMode.system)ようにしておくといいかも
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
        '/': (BuildContext context) => new MainScreen(),
        '/config': (BuildContext context) => new MyHomePage(),

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

