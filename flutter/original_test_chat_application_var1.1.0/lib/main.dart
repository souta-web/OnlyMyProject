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
  final List<dynamic> _messages = [];
  // DatabaseHelper クラスのインスタンス取得
  final dbHelper = DatabaseHelper.instance;

  // メッセージの送信処理
  void _sendMessage(int id) {
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        //ChatMessageクラスを呼び出すときにテキストと、送り主を引数で渡す
        // 送信されたテキストを画面右側に表示する
        if(_textEditingController.text.substring(0,4) == "todo" && _textEditingController.text.length > 3){
          _messages.add(SystemMessageInChat(
            text: _textEditingController.text,
            isChecked: false,
            id:id,
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
    final List<Map<String, dynamic>>? allmessage = await db?.query(
      'my_table',
      columns: ['id','message','todostate',], // 取得したいカラムのリスト
    );

    if (allmessage != null){
      for (final row in allmessage){
        final value1 = row['id'];
        final value2 = row['message'];
        final value3 = row['todostate'];

        setState(() {
          //ChatMessageクラスを呼び出すときにテキストと、送り主を引数で渡す
          // 送信されたテキストを画面右側に表示する
          if((value1.substring(0,4) == "todo") && (value1.length > 0)){
            _messages.add(SystemMessageInChat(
              id: value1,
              text: value2.toString(),
              isChecked: value3,
            ));
          }else{
            _messages.add(ChatMessage(
              text: value2.toString(),
              isSentByUser: true,
            ));
          }
        });
        print(value1.toString());//デバッグ用
      }
    }
  }

  // -ボタンクリック
  void _insert() async {
    // row to insert
    //データベースに登録
    Map<String, dynamic> row = {
      DatabaseHelper.columnSender : "true",
      DatabaseHelper.columnMessage : _textEditingController.text.toString(), //送信テキスト
      DatabaseHelper.columnTime : DateTime.now().toString(),
      DatabaseHelper.columnTodostate: "false",
    };
    final id = await dbHelper.insert(row);
    //print(_textEditingController.text);//デバッグ用
    _sendMessage(id);
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

  void initState() {
    _restorationMessage();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(//アプリの画面上部のバー
        title: Text('Chat App'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => {_delete()},//×ボタン
          ),
          IconButton(
            icon: Icon(Icons.emoji_objects),
            onPressed: () => {_query()},//電球ボタン
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => {_insert()},//使わない
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

//todoを追加した時のチャットひな形
class SystemMessageInChat extends StatelessWidget {
  // チャットメッセージのテキスト
  final String text;
  // チェックボックスの状態
  bool isChecked;
  // チャットのid
  final int id;
  //クラスを呼び出すときに引数を必要とする(辻)
  SystemMessageInChat({required this.text,required this.isChecked,required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 送信者に応じてメッセージの位置を調整する
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width, // 横幅をアプリ画面の横幅と同じにする
        decoration: BoxDecoration(
          // 送信者に応じてメッセージの背景色を設定する
          color: Color.fromARGB(255, 9, 255, 0),
          // 角丸のボーダーを適用する
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isChecked, // チェックボックスの状態
              onChanged: (value) {
                // チェックボックスの状態が変更された時の処理
                _checkboxstatechange(id);
                isChecked = !isChecked;
              },
            ),
            Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),
          ]
        )
      ),
    );
  }

    // todoのチェックボックスがチェックされたときの挙動
  void _checkboxstatechange(int id) async {
    // DatabaseHelper クラスのインスタンス取得
    final dbHelper = DatabaseHelper.instance;
    Database? db = await DatabaseHelper.instance.database;//データベース取得
    List<Map>? results = await db?.query('my_table', 
      where: "todostate=?",
      whereArgs: [id]);
    if (results == "true") {
      Map<String, dynamic> row = {
        DatabaseHelper.columnTodostate:'false'
      };
      final rowsAffected = await dbHelper.update(row);
      print('更新しました。 ID：$rowsAffected ');
    }else{
      Map<String, dynamic> row = {
        DatabaseHelper.columnTodostate:'true'
      };
      final rowsAffected = await dbHelper.update(row);
      print('更新しました。 ID：$rowsAffected ');
    }
  }
}