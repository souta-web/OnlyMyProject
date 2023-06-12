import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // テキスト入力フィールドのコントローラー
  final TextEditingController _textEditingController = TextEditingController();
  // チャットメッセージのリスト
  final List<ChatMessage> _messages = [];
  // DatabaseHelper クラスのインスタンス取得
  final dbHelper = DatabaseHelper.instance;

  // メッセージの送信処理
  void _sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        //ChatMessageクラスを呼び出すときにテキストと、送り主を引数で渡す
        // 送信されたテキストを画面右側に表示する
        _messages.add(ChatMessage(
          text: _textEditingController.text,
          isSentByUser: true,
        ));
        // 返信メッセージを画面左側に表示する
        _messages.add(ChatMessage(
          text: 'チャットを受信しました。',
          isSentByUser: false,
        ));
        _textEditingController.clear();
      });
    }
  }

  // -ボタンクリック
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : '山田　太郎',
      DatabaseHelper.columnAge  : 35,
      DatabaseHelper.columnSender : "true",
      DatabaseHelper.columnMessage : _textEditingController.text.toString(), //送信テキスト
      DatabaseHelper.columnTime : DateTime.now().toString(),
    };
    final id = await dbHelper.insert(row);
    //print(_textEditingController.text);//デバッグ用
    print('登録しました。id: $id');
  }

  // 照会ボタンクリック
  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }

  // 更新ボタンクリック
  void _update() async {
     Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : '鈴木　一郎',
      DatabaseHelper.columnAge  : 48
    };
    final rowsAffected = await dbHelper.update(row);
    print('更新しました。 ID：$rowsAffected ');
  }

  // 削除ボタンクリック
  void _delete() async {
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id!);
    print('削除しました。 $rowsDeleted ID: $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(//アプリの画面上部のバー
        title: Text('Chat App'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => {_delete()},
          ),
          IconButton(
            icon: Icon(Icons.emoji_objects),
            onPressed: () => {_query()},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => {_insert()},
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
                    _insert();
                    _sendMessage();
                  } 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  // チャットメッセージのテキスト
  final String text;
  // 送信者がユーザー自身かどうかのフラグ
  final bool isSentByUser;

  //クラスを呼び出すときに引数を必要とする(辻)
  ChatMessage({required this.text, required this.isSentByUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 送信者に応じてメッセージの位置を調整する
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          // 送信者に応じてメッセージの背景色を設定する
          color: isSentByUser ? Colors.blue : Colors.grey[300],
          // 角丸のボーダーを適用する
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
