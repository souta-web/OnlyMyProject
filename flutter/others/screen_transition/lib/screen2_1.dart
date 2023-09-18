import 'package:flutter/material.dart';

class Screen2_1 extends StatefulWidget {
  @override
  _Screen2_1 createState() => _Screen2_1();
}

class _Screen2_1 extends State<Screen2_1> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //呼び出し元画面から引数を受け取る
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ?? {'caller_screen': '/screen1_1'};
    final caller_screen = args['caller_screen']; //呼び出し元のルート名をcaller_screenに代入
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
                Navigator.pushNamed(context, caller_screen);//第２引数に呼び出し元ルート名が格納されている変数を指定
              },
              child: Text(caller_screen.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
