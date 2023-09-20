import 'package:flutter/material.dart';
import '/utils/media_controller.dart';
import 'dart:typed_data';
import '/utils/register_chat_table.dart';
import '/widget/chat_fukidashi.dart';

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
  late Uint8List? _mediaData = null; //メディアを格納する

  // チャットメッセージのリスト
  final List<dynamic> _messages = [
    ChatMessage(
      text: "テスト",
      isSentByUser: true,
    )
  ];

  //ほかのファイルの非同期処理関数をbuild内で呼び出して戻り値受け取れないからそれを可能にするための記述
  Future<Uint8List?> _getMedia() async {
    return await MediaController.getMedia();
  }

  // 新しいメッセージを追加する関数
  void addNewMessage() {
    _messages.add(
      ChatMessage(
        text: "新しいメッセージ",
        isSentByUser: true,
      ),
    );

    // UIを更新
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
                child: Column(children: [
                  //縦
                  Form(
                      child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                        GestureDetector(
                          onTap: () {
                            //コールバック関数の定義
                            setState(() {
                              //スイッチ状態をトグルする
                              _isTodo =
                                  !_isTodo; //スイッチの状態をトグル（ONからOFF,OFFからONに切替）
                            });
                          },
                          child: Container(
                            //padding:EdgeInsets.only(bottom: 10, left: 10), //アイコン動く
                            alignment: Alignment.center, // 円形の位置を中央に配置
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, //円形
                              color: _isTodo
                                  ? Colors.green
                                  : Colors.red, //スイッチの状態に応じて色の切替
                            ),
                            child: Image.asset(
                              _isTodo
                                  ? 'assets/images/chat_icon.png'
                                  : 'assets/images/chat_icon_d.png', // UI_.pdf のアイコンに置き換え
                              width: 18.0, //大きさ調整
                              height: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        /*Switch(
                          //テキスト入力欄の一番左のやつ
                          value: _isTodo,
                          onChanged: (value) {
                            setState(() {
                              _isTodo = value;
                              print(_isTodo);
                            });
                          },
                        ),*/
                        IconButton(
                          //メディア追加ボタン
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          alignment: Alignment.center, // 円形の位置を中央に配置
                          onPressed: () async {
                            _mediaData = await _getMedia();
                            //現状は取得したメディアの処理がないためprintで取得確認
                            print(_mediaData);
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
                                  //↓辻作成の登録プログラム動作確認用。カトゥーンのほうでも動作確認出来たら消してください。
                                  RegisterChatTable registerChatTable =
                                      RegisterChatTable(
                                    //インスタンス化、引数渡し
                                    chatSender: 'John',
                                    chatMessage: 'Hello!',
                                  );
                                  registerChatTable
                                      .registerChatTableFunc(); //実際にデータベース登録
                                  addNewMessage(); //新しいメッセージの追加
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
