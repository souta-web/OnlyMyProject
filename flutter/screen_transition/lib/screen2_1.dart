import 'package:flutter/material.dart';

class Screen2_1 extends StatefulWidget {
  @override
  _Screen2_1 createState() => _Screen2_1();
}

class _Screen2_1 extends State<Screen2_1> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('screen2_1'),
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
          ],
        ),
      ),
    );
  }
}
