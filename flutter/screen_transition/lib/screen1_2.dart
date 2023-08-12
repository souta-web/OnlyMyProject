import 'package:flutter/material.dart';

class Screen1_2 extends StatefulWidget {
  @override
  _Screen1_2 createState() => _Screen1_2();
}

class _Screen1_2 extends State<Screen1_2> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('screen1_2'),
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
                  hintText: '2-1から戻った時に再描画されない',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // ボタンが押されたときの処理をここに追加
                Navigator.pushNamed(context, '/screen2_1');
              },
              child: Text('screen2_1'),
            ),
          ],
        ),
      ),
    );
  }
}
