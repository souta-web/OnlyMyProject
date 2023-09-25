import 'package:flutter/material.dart';

// 辻が作った吹き出し
class ChatMessage extends StatelessWidget {
  // チャットメッセージのテキスト
  final String text;
  // 送信者がユーザー自身かどうかのフラグ
  //ユーザー送信=true
  final bool isSentByUser;
  
  //時間
  final String? time;

  //クラスを呼び出すときに引数を必要とする(辻)
  ChatMessage({
    required this.text,
    required this.isSentByUser,
    this.time,
  });

  @override
  
  Widget build(BuildContext context) {

    final String _time = time ?? "12:34 default"; //時間の取得と引数で受け取れなかった時のデフォルト処理

    return Row(
      // 送信者に応じてメッセージの位置を調整する
      mainAxisAlignment: isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _createBlank(isSentByUser),
        _createTimeWidget(_time,isSentByUser),
        Flexible(
          child:Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            // 送信者に応じてメッセージの背景色を設定する
            color: isSentByUser
                ? Color.fromARGB(255, 255, 149, 21)
                : Color.fromARGB(255, 189, 187, 184),
            // 角丸のボーダーを適用する
            borderRadius: isSentByUser
              ? const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),

          ),
        ),
        _createTimeWidget(_time,!isSentByUser),
        _createBlank(!isSentByUser),
      ],
    );
  }

  Widget _createTimeWidget(String _time,bool _drawTime) {
    if(_drawTime == true) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
        alignment: Alignment.bottomCenter,
        child:Text(
          // 時間情報を表示
          _time,
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        )
      );
    }else{
      return const SizedBox(width: 10); //空のウィジェットを返す
    }
  }

  Widget _createBlank(bool _useBlank) {
    if (_useBlank == true) {
      return const SizedBox(width: 50);
    } else {
      return const SizedBox();
    }
  }
}