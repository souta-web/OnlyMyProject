import 'package:flutter/material.dart';
import 'chat_fukidashi.dart';

void main() {
  runApp(const MyApp());
}

//MyAppの中身は無視でよい
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//実際に表示されている画面以下
//_messagesに吹き出しのクラスを格納して画面に表示されるように作ってほしい
class _MyHomePageState extends State<MyHomePage> {
  //
  final List<dynamic> _messages =[ChatMessage(text: "aaaa",isSentByUser: true),
                                  ChatMessage(text: "testdayo", isSentByUser: false)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length, //_messagesの中身の数を取得する
              itemBuilder: (context, index) { //47,48行目で画面描画用の吹き出し作成
                return _messages[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}

//辻が作った吹き出し
class ChatMessage extends StatelessWidget {
  // チャットメッセージのテキスト
  final String text;
  // 送信者がユーザー自身かどうかのフラグ
  final bool isSentByUser;

  //クラスを呼び出すときに引数を必要とする(辻)
  ChatMessage({required this.text, required this.isSentByUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 送信者に応じてメッセージの位置を調整する
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          // 送信者に応じてメッセージの背景色を設定する
          color: isSentByUser ? Color.fromARGB(255, 255, 149, 21) : Color.fromARGB(255, 189, 187, 184),
          // 角丸のボーダーを適用する
          borderRadius: isSentByUser ?
          BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ) : 
          BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
