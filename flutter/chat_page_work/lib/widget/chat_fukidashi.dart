import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 辻が作った吹き出し
class ChatMessage extends StatelessWidget {
  // チャットメッセージのテキスト
  final String text;
  // 送信者がユーザー自身かどうかのフラグ
  final bool isSentByUser;

  //クラスを呼び出すときに引数を必要とする(辻)
  ChatMessage({
    required this.text,
    required this.isSentByUser,
  });

  String getCurrentTime() {
    //現在時刻
    final now = DateTime.now();
    final formattedTime = DateFormat.jm().format(now); //現在時刻をフォーマット
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //縦
      crossAxisAlignment: isSentByUser
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start, //子要素の垂直方向制御
      children: [
        Row(
          //横
          mainAxisAlignment: isSentByUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start, //子要素の水平方向制御
          children: [
            Padding(
                //時間の余白…
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  getCurrentTime(), //現在時刻表示
                  style: TextStyle(fontSize: 12.0, color: Colors.black),
                )),
            //SizedBox(width: 3.0), //時刻とメッセージの間にスペース設定
            Container(
              margin: EdgeInsets.only(
                right: isSentByUser ? 8.0 : 64.0, // 送信者によって右側または左側の余白設定
                left: isSentByUser ? 64.0 : 8.0,
                bottom: 8.0, // 下側の余白設定
                top: 8.0,
              ),
              padding: EdgeInsets.all(10.0), //テキスト内の余白
              decoration: BoxDecoration(
                color: isSentByUser
                    ? Color.fromARGB(255, 255, 149, 21)
                    : Color.fromARGB(255, 189, 187, 184), //送信者に応じての背景色
                borderRadius: isSentByUser
                    ? BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10), // 角丸のボーダー
                      ),
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.0), // 時間とメッセージの間に垂直方向のスペースを設定
      ],
    );
  }
}
