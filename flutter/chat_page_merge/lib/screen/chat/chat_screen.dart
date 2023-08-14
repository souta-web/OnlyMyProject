import 'package:flutter/material.dart';
import '/widget/chat_fukidashi.dart';
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
  final List<ChatMessage> _messages = [
    ChatMessage(text: "aaaa", isSentByUser: true), // isSentByUserがtrueはユーザーが送信
    ChatMessage(text: "testdayo", isSentByUser: false), // falseはAIが返信する
  ];
  //今はサンプルのデータを入れているけど実際には空の状態でプログラムを動作させます

  // メッセージの送信を処理するメソッド
  void _handLeSubmitted(String text) {
    // テキストをデータベースに登録して返答メッセージを表示する
    _registerAndShowReplyMessage(text);

    // 新しいチャットメッセージを作成する
    ChatMessage message =
        ChatMessage(text: text, isSentByUser: true); // 送信側のメッセージ
    // チャットメッセージをリストの先頭に追加する
    _messages.insert(0, message);

    // テキスト入力をクリアする
    _textEditingController.clear();
  }

  // テキストをデータベースに登録し、返答メッセージを表示するメソッド
  _registerAndShowReplyMessage(String text) {
    // テキストをデータベースに登録
    RegisterText.registerTextToDatabase(text, 1); // 1は送信者を'ユーザー'とする
    if (_textEditingController.text.isNotEmpty) {
      // テキストフィールドに値が入っているかチェック
      String replyText = "データが登録されました"; // 返信メッセージの内容
      print(replyText);
      ChatMessage replayMessage =
          ChatMessage(text: replyText, isSentByUser: false);
      _messages.insert(0, replayMessage);
    }
  }

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
                            // チャットテーブルのデータを取得
                            final dbHelper = DatabaseHelper.instance;
                            final List<Map<String, dynamic>> chats =
                                await dbHelper.queryAllRows_chat_table();

                            print("チャットテーブルのデータ:");
                            chats.forEach((chat) {
                              print(
                                  "Sender: ${chat[DatabaseHelper.columnChatSender]}, Todo: ${chat[DatabaseHelper.columnChatTodo]}, Text: ${chat[DatabaseHelper.columnChatMessage]}, Time: ${chat[DatabaseHelper.columnChatTime]} Channel: ${chat[DatabaseHelper.columnChatChannel]},");
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
                                  _handLeSubmitted(_textEditingController.text);
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
