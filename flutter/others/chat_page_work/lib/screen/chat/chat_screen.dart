import 'package:flutter/material.dart';
import '/utils/media_controller.dart';
import 'dart:typed_data';
import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';

class ChatScreenWidget extends StatefulWidget {
  @override
  _ChatScreenWidget createState() => _ChatScreenWidget();
}

class _ChatScreenWidget extends State<ChatScreenWidget> {
  // テキスト入力フィールドのコントローラー
  final TextEditingController _textEditingController = TextEditingController();
  //switchボタンの状態管理変数
  //bool _isTodo = false; //テキスト入力の左のやつ
  bool _isTodo = true; //初期値
  double iconsSize = 30;

  // チャットメッセージのリスト
  final List<dynamic> _messages = [
    ChatMessage(text: "テスト",isSentByUser: true,time: "4:44"),
    ChatMessage(text: "テスasdddddddddddddddddddddddddddddddddddddddfffト",isSentByUser: false,time: "5:44"),
    ChatTodo(title: "ご飯食べる",isSentByUser: true,mainTag: "ご飯",startTime: "18:30",actionFinished: true,mainTagColor: Colors.red,)
  ];

  //ほかのファイルの非同期処理関数をbuild内で呼び出して戻り値受け取れないからそれを可能にするための記述
  Future<Uint8List?> _getMedia() async {
    return await MediaController.getMedia();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //appbarを作成
          title: Text('Chat'),
          //左上のアイコン
          leading: IconButton(
            //左上のアカウントアイコン
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/account_icon.png'),
              backgroundColor: Colors.transparent, // 背景色
              radius: 25,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              //右上の三点リーダーのやつ
              icon: Icon(Icons.more_vert),
              onPressed: () {
                Navigator.pushNamed(context, '/config'); //routeに追加したconfigに遷移
              },
            ),
            IconButton(
              icon: Icon(Icons.data_usage),
              onPressed: () async {},
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              //Expandedの中身が吹き出しを表示するためのプログラム。_messages配列の中身をListView形式でループして表示させている
              child: ListView.builder(
                itemCount: _messages.length, //表示させるアイテムのカウント
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            Container(
                color: Color.fromARGB(255, 103, 100, 100),
                child: Column(
                  children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              padding:const EdgeInsets.all(0), //アイコン動く
                              child: Image.asset(
                                _isTodo ? 'assets/images/textfield_action_submit_true.png'
                                        : 'assets/images/textfield_action_submit_false.png', // UI_.pdf のアイコンに置き換え
                                height:iconsSize,
                                width:iconsSize
                              ),
                            ),
                            onTap: () {
                              //コールバック関数の定義
                              setState(() {
                                //スイッチ状態をトグルする
                                _isTodo = !_isTodo; //スイッチの状態をトグル（ONからOFF,OFFからONに切替）
                              });
                            },
                          ),
                          IconButton(
                            //メディア追加ボタン
                            icon: Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () async {
                            },
                            iconSize: iconsSize,
                          ),
                          Flexible(
                            child:Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 222, 216, 216),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.multiline,//複数行のテキスト入力
                                style: const TextStyle(fontSize: 16), // テキストのフォントサイズを変更
                                maxLines: 5,
                                minLines: 1,
                                cursorColor: Color.fromARGB(255, 75, 67, 93),
                                decoration:const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'メッセージを入力してください',
                                  //hintTextの位置
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 0.0,
                                  ),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ),
                          Material(
                            //送信ボタンを作成
                            color: Color.fromARGB(255, 103, 100, 100),
                            child: Center(
                              child: Ink(
                                child: IconButton(
                                  icon: Icon(Icons.send),
                                  color: Colors.white,
                                  onPressed: () {
                                  },
                                  iconSize: iconsSize,
                                ),
                              ),
                            ),
                          )
                        ]
                      )
                ])),
          ],
        ));
  }
}
