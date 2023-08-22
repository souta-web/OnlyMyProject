import 'package:flutter/material.dart';

//辻が作った吹き出し
class ChatMessage extends StatelessWidget {
  // チャットメッセージのテキスト
  final String text;
  // 送信者がユーザー自身かどうかのフラグ
  final bool isSentByUser;

  //クラスを呼び出すときに引数を必要とする(辻)
  ChatMessage({required this.text, required this.isSentByUser,});

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
