import 'func/draw_chat_objects.dart';
import 'package:flutter/material.dart';
import '/utils/media_controller.dart';
import '/screen/chat/func/auto_scroll.dart';
import '/screen/chat/func/restore_chat_history.dart';
import '/utils/convert_media.dart';
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

  late List<Uint8List> imageData = []; // メディアを格納するリスト
  // チャットメッセージのリスト
  final List<dynamic> _messages = [];

  // DrawChatObjectsをfinal修飾子で宣言
  final DrawChatObjects _chatObjects = DrawChatObjects();

  late ScrollController
      _scrollController; // ScrollControllerをChatScreenWidget内で生成
  // 自動スクロールクラスのインスタンス生成
  late AutoScroll _autoScroll;

  // フォーカスノードのインスタンス生成
  final FocusNode _focusNode = FocusNode();

  // チャット履歴復元クラスのインスタンス生成
  final RestoreChatHistory _restoreChatHistory = RestoreChatHistory();
  final ConvertMedia _convertMedia = ConvertMedia();

  // バイナリーデータに変換するためのリスト
  final List<Uint8List> _imageList = [];

  final double iconsSize = 30; //アイコンサイズ

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
    final List<dynamic> chatMessages = _restoreChatHistory.getMessages();

    setState(() {
      print('chatMessages: $chatMessages');
      _messages.addAll(chatMessages);
      print(_messages);
    });

    // アプリ起動時に自動スクロール
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
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(0), //アイコン動く
                      child: Image.asset(
                          _isTodo
                              ? 'assets/images/textfield_action_submit_true.png'
                              : 'assets/images/textfield_action_submit_false.png', // UI_.pdf のアイコンに置き換え
                          height: iconsSize,
                          width: iconsSize),
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
                      _mediaData = await _getMedia();
                      imageData = await _convertMedia
                          .pickAndConvertImages(List.from(_imageList));
                      //現状は取得したメディアの処理がないためprintで取得確認
                      print(_mediaData);
                      // print('imageData: $imageData');
                      setState(() {
                        _imageList.addAll(imageData);
                      });
                    },
                    iconSize: iconsSize,
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 222, 216, 216),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _textEditingController,
                        keyboardType: TextInputType.multiline, //複数行のテキスト入力
                        style: const TextStyle(fontSize: 16), // テキストのフォントサイズを変更
                        maxLines: 5,
                        minLines: 1,
                        cursorColor: Color.fromARGB(255, 75, 67, 93),
                        decoration: const InputDecoration(
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
                            setState(() {
                              //表示させたい内容はreturnで帰ってきて_messagesに渡されるので、引数にする必要はない。
                              print('送信ボタンが押されました');
                              _messages.add(_chatObjects.sendButtonPressed(
                                  _textEditingController.text,
                                  _isTodo,
                                  _textEditingController,
                                  true,
                                  _imageList));
                              _autoScroll.scrollToBottom();
                            });
                          },
                          iconSize: iconsSize,
                        ),
                      ),
                    ),
                  )
                ]),
              ],
            ),
          ),
        ]));
  }
}
