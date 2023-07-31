import 'package:flutter/material.dart';

class ScreenTransition {
  // 画面のルート名を定義
  static const String timelineRoute = '/timeline';
  static const String chatRoute = '/chat';

  // タイムライン画面から遷移してきたか判定するメソッド
  static bool isFromTimelineScreen(BuildContext context) {
    final ModalRoute<dynamic>? currentRoute = ModalRoute.of(context);
    return currentRoute?.settings.name == timelineRoute;
  }

  // チャット画面から遷移してきたか判定するメソッド
  static bool isFromChatScreen(BuildContext context) {
    final ModalRoute<dynamic>? currentRoute = ModalRoute.of(context);
    return currentRoute?.settings.name == chatRoute;
  }

  // タイムライン画面に遷移するメソッド
  static void goToTimeline(BuildContext context) {
    Navigator.pushNamed(context, timelineRoute);
  }

  // チャット画面に遷移するメソッド
  static void goToChat(BuildContext context) {
    Navigator.pushNamed(context, chatRoute);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ScreenTransition.timelineRoute, // 最初に表示する画面のルート名を指定
      routes: {
        // 画面のルート名と対応するWidgetを指定
        ScreenTransition.timelineRoute: (context) => TimelineScreen(),
        ScreenTransition.chatRoute: (context) => ChatScreen(),
      },
    );
  }
}

class TimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timeline')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => ScreenTransition.goToChat(context), // チャット画面に遷移するボタン
          child: Text('Go to Chat'),
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isFromTimeline = ScreenTransition.isFromTimelineScreen(context); // タイムライン画面から遷移してきたかを判定

    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Center(
        child: Text(
          isFromTimeline
              ? 'Coming from Timeline' // タイムライン画面から遷移してきた場合
              : 'Not coming from Timeline', // タイムライン画面以外から遷移してきた場合
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
