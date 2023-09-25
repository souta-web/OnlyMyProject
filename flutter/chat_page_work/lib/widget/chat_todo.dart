import 'package:flutter/material.dart';

class ChatTodo extends StatefulWidget {
  final String title; //チャットメッセージのテキスト
  final bool isSentByUser; //送信者がユーザー自信かどうかのフラグ
  final String? mainTag; //メインタグ
  final Color? mainTagColor; //メインタグの色
  final String startTime; //送信時刻
  final bool actionFinished; // アクションの状態(true="完了",false="未完了")

  //クラスを呼び出すときに引数を必要とする(辻)
  ChatTodo({
    required this.title,
    required this.isSentByUser,
    this.mainTag,
    this.mainTagColor,
    required this.startTime,
    required this.actionFinished,
  });

  //ウィジェットの状態を管理するStateオブジェクトを生成する
  @override
  _ChatTodoState createState() => _ChatTodoState();
}

//ウィジェットの状態を管理するStateクラス定義
class _ChatTodoState extends State<ChatTodo> {
  late bool _isActionFinished; //アクションの完了状態を示すフラグ

  @override
  void initState() {
    super.initState();
    _isActionFinished = widget.actionFinished; //アクションの初期状態をウィジェットから取得
  } //ウィジェットが初めて表示されたときのアクションの状態が設定されます。

  @override
  Widget build(BuildContext context) {
    String iconAsset = _isActionFinished
        ? 'assets/images/play_circle.png' //未完了アイコン
        : 'assets/images/stop_recording.png'; //完了アイコン

    return Container(
      color: Color.fromARGB(255, 229, 229, 229),
      margin: EdgeInsets.symmetric(vertical: 20.0),
      padding: EdgeInsets.all(7.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    widget.startTime,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    if (widget.mainTag != null) //mainTagプロパティがnullでない場合
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: widget.mainTagColor ?? Colors.blueAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          widget.mainTag!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 11.0,
                          ),
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
                    //円形アイコン表示
                    backgroundImage: AssetImage(iconAsset),
                    backgroundColor: Colors.transparent,
                    radius: 25,
                  ),
                  onPressed: () {
                    //ボタンが押されたとき実行されるコード
                    if (!_isActionFinished) {
                      //もしアクションが未完了の場合
                      setState(() {
                        //状態を更新するため呼び出す
                        _isActionFinished = true; // アクションが完了したことを示すフラグを設定
                      });
                      //print("アクションが切り替わりました。");
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
