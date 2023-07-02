import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';
import 'chatpagewidget.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // テキスト入力フィールドのコントローラー
  final TextEditingController _textEditingController = TextEditingController();
  // チャットメッセージのリスト
  final List<dynamic> _messages = [];
  // DatabaseHelper クラスのインスタンス取得
  final dbHelper = DatabaseHelper.instance;

  late var _file_path; //ユーザーがファイルを送信するときにここにそのディレクトリが入る
  late Uint8List? _file_data = null;

  bool _isTodo = false;//テキスト入力の左のやつ

  @override

  void initState() {
    _restorationMessage();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(//アプリの画面上部のバー
        title: Text('Chat Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => {_delete_chat_table()},//×ボタン
          ),
          IconButton(
            icon: Icon(Icons.emoji_objects),//照会する
            onPressed: () => {_query_chat_table(),_query_action_table()},//電球ボタン
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Divider(),
          //テキスト入力欄
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Row(
                  children: [
                    Switch(
                      value: _isTodo,
                      onChanged: (value) {
                        setState(() {
                          _isTodo = value;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _addButtonPressed();
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'メッセージを入力してください...',
                    ),
                  ),
                ),
                //チャット画面の送信ボタン
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed:() {
                    if (_textEditingController.text != "") {
                      _insert_chat_table();//データベースに対する送信処理
                    }
                  } 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
    // メッセージの送信処理
  void _sendMessage(int _id,bool _todo) {
    print(_todo);
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        //ChatMessageクラスを呼び出すときにテキストと、送り主を引数で渡す
        // 送信されたテキストを画面右側に表示する
        if(_todo){
          print("todoが追加");
          _messages.add(TodoMessage(
            text: _textEditingController.text,
            isChecked: 0,
            id:_id,
            media:_nullCheckMedia(_file_data),
          ));
        }else{
          _messages.add(ChatMessage(
            text: _textEditingController.text,
            isSentByUser: true,
          ));
          // 返信メッセージを画面左側に表示する
          _messages.add(ChatMessage(
            text: 'チャットを受信しました。',
            isSentByUser: false,
          ));
        }
        //テキストボックスclear
        _textEditingController.clear();
      });
    }
  }

  void _restorationMessage() async {
    //すべての送信メッセージ取得
    Database? db = await DatabaseHelper.instance.database;//データベース取得
    final List<Map<String, dynamic>>? chat_table_message = await db?.query(
      'chat_table',
      columns: ['_chat_id','chat_todo','chat_todofinish','chat_message'], // 取得したいカラムのリスト
    );
    final List<Map<String, dynamic>>? action_table_message = await db?.query(
      'action_table',
      columns: ['_action_id','action_name','action_state','action_Start','action_End','action_media'], // 取得したいカラムのリスト
    );

    var action_index = 0;//todoの数をカウントするための変数

    if (chat_table_message != null){
      for (final row in chat_table_message){
        final chat_table_message = row['chat_message'];
        final chat_table_todo = row['chat_todo'];
        final chat_table_id = row['_chat_id'];
        setState(() {
          //ChatMessageクラスを呼び出すときにテキストと、送り主を引数で渡す
          // 送信されたテキストを画面右側に表示する
          if (chat_table_todo == "1"){//todoのとき
            final action_table_id = action_table_message?[action_index]['_action_id'];
            final action_table_name = action_table_message?[action_index]['action_name'];
            final action_table_state = action_table_message?[action_index]['action_state'];
            final action_table_start = action_table_message?[action_index]['action_start'];
            final action_table_end = action_table_message?[action_index]['action_end'];
            final action_table_media = _nullCheckMedia(action_table_message?[action_index]['action_media']);
            _messages.add(TodoMessage(
              text: action_table_name,
              isChecked: action_table_state,
              id:action_table_id,
              media:action_table_media,//バイナリデータを引き渡す
            ));
            action_index += 1;
            print("todo");
          }else{//通常チャットの時
            _messages.add(ChatMessage(
              text: chat_table_message,
              isSentByUser: true,
            ));
            print("チャット");
          }
          
        });
      }
    }
  }

  Uint8List? _nullCheckMedia(var _media) {
    if (_media != null){
      return _media;
    } else {
      return null;
    }
  }

  //送信ボタン
  void _insert_chat_table() async {
    // row to insert
    //データベースに登録
    print("これからデータベース登録");
    Map<String, dynamic> row = {
      DatabaseHelper.columnChatSender : "true",
      DatabaseHelper.columnChatTodo : _isTodo,
      DatabaseHelper.columnChatMessage : _textEditingController.text.toString(), //送信テキスト
      DatabaseHelper.columnChatTime : DateTime.now().toString(),
      DatabaseHelper.columnChatTodofinish:false,
    };
    final id = await dbHelper.insert_chat_table(row);
    //print(_textEditingController.text);//デバッグ用
    print('登録しました。id: $id');

    if (_isTodo){
      _insert_action_table(id);
    }

    _sendMessage(id,_isTodo);//画面処理
  }

  void _addButtonPressed() async {
    final result = await FilePicker.platform.pickFiles();//選択されたファイルを取得する
    if (result != null) {
      // ファイルが選択された場合の処理
      // 選択されたファイルにアクセスするための情報は`result`オブジェクトに含まれます
      // 例えば、`result.files.single.path`でファイルのパスにアクセスできます
      final path = result.files.single.path;
      if (path != null) {
        // ファイルにアクセスして適切な処理を行います
        final bytes = await io.File(path).readAsBytes();
        _file_data = Uint8List?.fromList(bytes);
      }
    } else {
      // キャンセルされた場合の処理
    }
  }

  // 照会ボタンクリック
  void _query_chat_table() async {
    final allRows = await dbHelper.queryAllRows_chat_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }

  // 削除ボタンクリック
  void _delete_chat_table() async {
    final id = await dbHelper.queryRowCount_chat_table();
    final rowsDeleted = await dbHelper.delete_chat_table(id!);
    _delete_action_table(id);
    print('削除しました。 $rowsDeleted ID: $id');
  }

  //action_table用の関数
  //送信ボタン
  void _insert_action_table(int _id) async {
    // row to insert
    //データベースに登録
    print("これからデータベース登録");
    Map<String, dynamic> row = {
      DatabaseHelper.columnActionId : _id,
      DatabaseHelper.columnActionName : _textEditingController.text.toString(),
      DatabaseHelper.columnActionStart : DateTime.now().toString(),
      DatabaseHelper.columnActionEnd : null,
      DatabaseHelper.columnActionDuration : null,
      DatabaseHelper.columnActionMessage : null,
      DatabaseHelper.columnActionMedia : _file_data,
      DatabaseHelper.columnActionNotes : null,
      DatabaseHelper.columnActionScore : null,
      DatabaseHelper.columnActionState : 0,
      DatabaseHelper.columnActionPlace : null,

    };
    await dbHelper.insert_action_table(row);
    //print(_textEditingController.text);//デバッグ用
    print('登録しました。id: $_id');
  }

  // 照会ボタンクリック
  void _query_action_table() async {
    final allRows = await dbHelper.queryAllRows_action_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }

  // 削除ボタンクリック
  void _delete_action_table(int _id) async {
    final rowsDeleted = await dbHelper.delete_action_table(_id!);
    print('削除しました。 $rowsDeleted ID: $_id');
  }
}
