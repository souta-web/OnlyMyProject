import 'package:flutter/material.dart';
import '/screen/chat/func/register_text.dart';
import '/utils/database_helper.dart';

class ChatScreenWidget extends StatefulWidget {
  @override
  _ChatScreenWidget createState() => _ChatScreenWidget();
}

class _ChatScreenWidget extends State<ChatScreenWidget> {
  // テキスト入力フィールドのコントローラー
  final TextEditingController _textEditingController = TextEditingController();

  // チャットメッセージのリスト
  final List<dynamic> _messages = [];

  @override
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
                child: Column(children: [
                  Form(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                        IconButton(
                          icon: Icon(Icons.textsms),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          //メディア追加ボタン
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () async {
                            // ここでデータ確認できます
                            // チャットテーブルのデータを取得
                            final dbHelper = DatabaseHelper.instance;
                            final List<Map<String, dynamic>> chats =
                                await dbHelper.queryAllRows_chat_table();

                            print("チャットテーブルのデータ:");
                            chats.forEach((chat) {
                              print(
                                  "ID: ${chat[DatabaseHelper.columnChatId]}, Sender: ${chat[DatabaseHelper.columnChatSender]}, Todo: ${chat[DatabaseHelper.columnChatTodo]}, Text: ${chat[DatabaseHelper.columnChatMessage]}, Time: ${chat[DatabaseHelper.columnChatTime]} ChatActionId: ${chat[DatabaseHelper.columnChatActionId]},");
                            });
                          },
                        ),
                        Flexible(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 222, 216, 216),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _textEditingController,
                            keyboardType: TextInputType.multiline, //複数行のテキスト入力
                            maxLines: 5,
                            minLines: 1,
                            cursorColor: Color.fromARGB(255, 75, 67, 93),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'メッセージを入力してください',
                                //hintTextの位置
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 11.0,
                                )),
                          ),
                        )),
                        Material(
                          //送信ボタンを作成
                          color: Color.fromARGB(255, 103, 100, 100),
                          child: Center(
                            child: Ink(
                              child: IconButton(
                                icon: Icon(Icons.send),
                                color: Colors.white,
                                onPressed: () {
                                  //ここに送信ボタンが押された時の動作を記述する
                                  //ここの中で関数を呼び出す
                                  String text = _textEditingController.text;
                                  // メッセージ送信処理をするメソッドを呼び出す
                                  RegisterText.handLeSubmitted(
                                      text, _messages, _textEditingController);

                                  // Stateを更新して表示を更新する
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        )
                      ])),
                ])),
          ],
        ));
  }
}
