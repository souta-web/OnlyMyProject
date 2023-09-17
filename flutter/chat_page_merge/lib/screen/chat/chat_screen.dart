import '/utils/draw_chat_objects.dart';
import 'package:flutter/material.dart';
import '/utils/media_controller.dart';
import '/screen/chat/func/auto_scroll.dart';
import '/screen/chat/func/restore_chat_history.dart';
import 'dart:typed_data';

class ChatScreenWidget extends StatefulWidget {
  @override
  _ChatScreenWidget createState() => _ChatScreenWidget();
}

class _ChatScreenWidget extends State<ChatScreenWidget> {
  // テキスト入力フィールドのコントローラー
  final TextEditingController _textEditingController = TextEditingController();
  //switchボタンの状態管理変数
  bool _isTodo = false; //テキスト入力の左のやつ
  late Uint8List? _mediaData = null; //メディアを格納する

  // チャットメッセージのリスト
  final List<dynamic> _messages = [];

  // DrawChatObjectsをfinal修飾子で宣言
  final DrawChatObjects _chatObjects = DrawChatObjects();

  late ScrollController _scrollController; // ScrollControllerをChatScreenWidget内で生成
  // 自動スクロールクラスのインスタンス生成
  late AutoScroll _autoScroll;

  // フォーカスノードのインスタンス生成
  final FocusNode _focusNode = FocusNode();

  // チャット履歴復元クラスのインスタンス生成
  final RestoreChatHistory _restoreChatHistory = RestoreChatHistory();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _autoScroll = AutoScroll(_scrollController, context);
    _loadChatHistory();

    // フォーカスノードのリスナーを追加
    _focusNode.addListener(_onTextEditingFieldFocus);
  }

  // フォーカスが変更されたときに呼ばれるメソッド
  void _onTextEditingFieldFocus() {
    if (_focusNode.hasFocus) {
      // テキストフィールドがフォーカスされた場合、オートスクロールを実行
      _autoScroll.scrollToBottom();
    }
  }

  @override
  void dispose() {
    // ウィジェットが破棄される際にリスナーを削除
    _focusNode.removeListener(_onTextEditingFieldFocus);
    super.dispose();
  }

  // チャット履歴を読み込むメソッド
  void _loadChatHistory() async {
    await _restoreChatHistory.fetchChatHistory();
    final List<Widget> chatMessages = _restoreChatHistory.getMessages();

    setState(() {
      _messages.addAll(chatMessages);
      print(_messages);
    });

    //アプリ起動時に自動スクロール
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScroll.scrollToBottom();
    });
  }

  //ほかのファイルの非同期処理関数をbuild内で呼び出して戻り値受け取れないからそれを可能にするための記述
  Future<Uint8List?> _getMedia() async {
    return await MediaController.mediaAddButtonPressed();
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
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            //Expandedの中身が吹き出しを表示するためのプログラム。_messages配列の中身をListView形式でループして表示させている
            child: ListView.builder(
              controller: _scrollController, // ScrollControllerをListViewに指定
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
                          focusNode: _focusNode,  // フォーカスノードを関連付ける
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
                                setState(() {
                                  //表示させたい内容はreturnで帰ってきて_messagesに渡されるので、引数にする必要はない。
                                  _messages.add(_chatObjects.sendButtonPressed(
                                      _textEditingController.text,
                                      _isTodo,
                                      _textEditingController,
                                      true));
                                  _autoScroll.scrollToBottom();
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    ])),
              ])),
        ],
      ),
    );
  }
}
