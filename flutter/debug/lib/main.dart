import 'package:flutter/material.dart';
import 'second_screen.dart';
import 'chat_screen.dart';

void main() {
  runApp(MyApp());
}


// 画面遷移デバッグ用です
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DebugScreen(),
      onGenerateRoute: (settings) {
        // SecondScreenに移動するための初期設定
        if (settings.name == '/second') {
          return MaterialPageRoute(
            builder: (context) => SecondScreen(),
          );
        }
        // ChatScreenに移動するための初期設定
        if (settings.name == '/chat') {
          return MaterialPageRoute(
            builder: (context) => ChatScreen(),
          );
        }
         // ルート名が'/second'or'/chat'以外の場合はホーム画面に遷移
        return MaterialPageRoute(
          builder: (context) => DebugScreen(),
          settings: settings,
        );
      },
    );
  }
}

class DebugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('画面遷移'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16.0), // ボタン間のスペース
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: Text('Second Screen へ遷移'),
            ),
            SizedBox(height: 16.0), // ボタン間のスペース
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chat');
              },
              child: Text('Chat Screen へ遷移'),
            ),
          ],
        ),
      ),
    );
  }
}
