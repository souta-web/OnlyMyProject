import 'package:flutter/material.dart';

class ChatTodo extends StatefulWidget {
  final String title; // チャットメッセージのテキスト
  final bool isSentByUser; // 送信者がユーザー自身かどうかのフラグ
  final String mainTag; //メインタグ
  final String startTime; //送信時刻
  final bool actionFinished; //アクションの状態(true="完了",false="未完了")

  //クラスを呼び出すときに引数を必要とする(辻)
  ChatTodo(
      {required this.title,
      required this.isSentByUser,
      required this.mainTag,
      required this.startTime,
      required this.actionFinished});

  //ウィジェットの状態を管理するStateオブジェクトを生成する
  @override
  _ChatTodoState createState() => _ChatTodoState();
}

//ウィジェットの状態を管理するStateクラス定義
class _ChatTodoState extends State<ChatTodo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color.fromARGB(255, 229, 229, 229),
          margin: EdgeInsets.symmetric(vertical: 20.0),
          padding: EdgeInsets.all(7.0),
          width: MediaQuery.of(context).size.width,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              child: Row(
                children: [
                  Text(
                    widget.startTime,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.title,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        widget.mainTag,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 11.0,
                          backgroundColor: Color.fromARGB(255, 134, 218, 239),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Material(
              color: Color.fromARGB(255, 229, 229, 229),
              child: Center(
                child: Ink(
                  child: IconButton(
                    icon: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/play_circle.png'),
                      backgroundColor: Colors.transparent, // 背景色
                      radius: 25,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
