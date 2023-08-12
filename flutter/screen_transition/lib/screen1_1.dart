import 'package:flutter/material.dart';

class Screen1_1 extends StatefulWidget {
  @override
  _Screen1_1 createState() => _Screen1_1();
}

class _Screen1_1 extends State<Screen1_1> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('screen1_1'),
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
                  hintText: '2_1から戻った時に再描画される',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // ボタンが押されたときの処理をここに追加
                Navigator.pushNamed(context, '/screen2_1').then((value) {
                  // 再描画
                  setState(() {});
                });
              },
              child: Text('screen2_1'),
            ),
          ],
        ),
      ),
    );
  }
}
