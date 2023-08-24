import '../../utils/chat_history_restorer.dart';
import 'package:flutter/material.dart';
import '/screen/chat/func/register_action.dart';

class ChatScreenWidget extends StatefulWidget {
  @override
  _ChatScreenWidget createState() => _ChatScreenWidget();
}

class _ChatScreenWidget extends State<ChatScreenWidget> {
  // テキスト入力フィールドのコントローラー
  final TextEditingController _textEditingController = TextEditingController();
  //switchボタンの状態管理変数
  bool _isTodo = false; //テキスト入力の左のやつ

  // チャットメッセージのリスト
  final List<dynamic> _messages = [];

  @override
  void initState() {
    super.initState();
    _restoreChatHistory();  // アプリ起動時にチャット履歴を復元
  }

  Future<void> _restoreChatHistory() async {
    await ChatHistoryRestorer.restoreChatHistory(_messages);
    setState(() {});
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
              onPressed: () async {
                // データ確認用メソッドの呼び出し
                //RegisterText.confirmData();
                RegisterAction.confirmChatActionData();
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
                        Switch(
                          //テキスト入力欄の一番左のやつ
                          value: _isTodo,
                          onChanged: (value) {
                            setState(() {
                              _isTodo = value;
                            });
                          },
                        ),
                        IconButton(
                          //メディア追加ボタン
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {},
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
                                  String _chatText =
                                      _textEditingController.text;

                                  // スイッチの状態を管理するメソッド
                                  RegisterAction.switchController(
                                      _isTodo,
                                      _chatText,
                                      _messages,
                                      _textEditingController);
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
