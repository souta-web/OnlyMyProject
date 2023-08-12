import 'package:flutter/material.dart';
import 'screen1_1.dart';
import 'screen1_2.dart';
import 'screen2_1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyScreen(),
        '/screen1_1': (context) => Screen1_1(),
        '/screen1_2': (context) => Screen1_2(),
        '/screen2_1': (context) => Screen2_1(),
      },
    );
  }
}

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'テキストを入力してください',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // ボタンが押されたときの処理をここに追加
                Navigator.pushNamed(context, '/screen1_1');
              },
              child: Text('screen1_1'),
            ),
            ElevatedButton(
              onPressed: () {
                // ボタンが押されたときの処理をここに追加
                Navigator.pushNamed(context, '/screen1_2');
              },
              child: Text('screen1_2'),
            ),
          ],
        ),
      ),
    );
  }
}
