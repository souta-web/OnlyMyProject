import 'package:flutter/material.dart';

// 辻が作った吹き出し
class ChatMessage extends StatelessWidget {
  // チャットメッセージのテキスト
  final String text;
  // 送信者がユーザー自身かどうかのフラグ
  final bool isSentByUser;
  //時間
  final String time;

  //クラスを呼び出すときに引数を必要とする(辻)
  ChatMessage({
    required this.text,
    required this.isSentByUser,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // 送信者に応じてメッセージの位置を調整する
      mainAxisAlignment: isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        _createTimeWidget(time,"left",isSentByUser),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            // 送信者に応じてメッセージの背景色を設定する
            color: isSentByUser
                ? Color.fromARGB(255, 255, 149, 21)
                : Color.fromARGB(255, 189, 187, 184),
            // 角丸のボーダーを適用する
            borderRadius: isSentByUser
              ? BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
          child: Text(
            text,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        _createTimeWidget(time,"right",isSentByUser),
      ],
    );
  }
  Widget _createTimeWidget(String _time,String _thisPosition,bool _isUser) {
    if (_thisPosition == "left") {
      if(_isUser == true) {
        return Text(
          // 時間情報を表示
          time,
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        );
      }else{
        return const SizedBox.shrink(); //空のウィジェットを返す
      }
    }else if(_thisPosition == "right") {
      if(_isUser == false) {
        return Text(
          // 時間情報を表示
          time,
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        );
      }else{
        return const SizedBox.shrink(); //空のウィジェットを返す
      }
    }else{
      return const SizedBox.shrink(); //空のウィジェットを返す
    }
  }
}
