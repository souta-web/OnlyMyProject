import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 辻が作った吹き出し
class ChatMessage extends StatelessWidget {
  // チャットメッセージのテキスト
  final String text;
  // 送信者がユーザー自身かどうかのフラグ
  final bool isSentByUser;
  // 時刻
  final String? time;

  //クラスを呼び出すときに引数を必要とする(辻)
  ChatMessage({
    required this.text,
    required this.isSentByUser,
    this.time,
  });

  String getCurrentTime() {
    //現在時刻
    final now = DateTime.now();
    final formattedTime = DateFormat.jm().format(now); //現在時刻をフォーマット、文字列として返す
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final String _time = time ?? getCurrentTime();

    return Row(
      //横
      mainAxisAlignment: isSentByUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start, //子要素の水平方向制御
      crossAxisAlignment: CrossAxisAlignment.end, //子要素の垂直方向制御
      children: [
        if (isSentByUser) SizedBox(width: 50), //true=右側に50px余白
        _createTimeWidget(_time, isSentByUser), //メッセージの時刻表示をするウィジェット追加
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            padding: EdgeInsets.all(10.0), //テキストの余白
            decoration: BoxDecoration(
              color: isSentByUser
                  ? Color.fromARGB(255, 255, 149, 21)
                  : Color.fromARGB(255, 189, 187, 184), //送信者に応じての背景色
              borderRadius: isSentByUser //角丸
                  ? BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))
                  : BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
        _createTimeWidget(_time, !isSentByUser), //相手からのメッセージの時、時刻表示を反対側に追加
        if (!isSentByUser) SizedBox(width: 50), //余白
      ],
    );
  }

  Widget _createTimeWidget(String _time, bool _drawTime) {
    //時刻表示ウィジェット作成
    if (_drawTime) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        alignment: Alignment.bottomCenter,
        child: Text(
          _time, //時刻の表示
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
      );
    } else {
      return SizedBox(width: 10); //空のウィジェット返す
    }
  }
}
