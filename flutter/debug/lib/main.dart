import 'package:flutter/material.dart';
import 'second_screen.dart';
import 'chat_screen.dart';
import 'screen_transition.dart';

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
                // 画面遷移前にcanPopメソッドを使って遷移元の画面から戻れるか判定
                bool canGoBack = ScreenTransition.canPop(context, '/second');
                // 判定結果に応じて遷移先への画面遷移を制御
                if (canGoBack) {
                  Navigator.pop(context); // 遷移元の画面に戻る
                } else {
                  Navigator.pushNamed(context, '/second'); // 遷移先の画面に遷移
                }
              },
              child: Text('Second Screen へ遷移'),
            ),
            SizedBox(height: 16.0), // ボタン間のスペース
            ElevatedButton(
              onPressed: () {
                // 画面遷移前にcanPopメソッドを使って遷移元の画面から戻れるか判定
                bool canGoBack = ScreenTransition.canPop(context, '/chat');
                // 判定結果に応じて遷移先への画面遷移を制御
                if (canGoBack) {
                  Navigator.pop(context); // 遷移元の画面に戻る
                } else {
                  Navigator.pushNamed(context, '/chat'); // 遷移先の画面に遷移
                }
              },
              child: Text('Chat Screen へ遷移'),
            ),
          ],
        ),
      ),
    );
  }
}
