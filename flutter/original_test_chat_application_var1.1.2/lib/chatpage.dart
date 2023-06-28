import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';


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
  void _sendMessage(int _id,String _todo) {
    print(_todo);
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        //ChatMessageクラスを呼び出すときにテキストと、送り主を引数で渡す
        // 送信されたテキストを画面右側に表示する
        if(_todo == "true"){
          print("todoが追加");
          _messages.add(TodoMessage(
            text: _textEditingController.text,
            isChecked: 0,
            id:_id,
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
      columns: ['_id','todo','todofinish','message'], // 取得したいカラムのリスト
    );

    if (allmessage != null){
      for (final row in allmessage){
        final _message = row['message'];
        final _todo = row['todo'];
        final _todofinish = row['todofinish'];
        final _id = row['_id'];
        setState(() {
          //ChatMessageクラスを呼び出すときにテキストと、送り主を引数で渡す
          // 送信されたテキストを画面右側に表示する
          if (_todo == "true"){
            _messages.add(TodoMessage(
              text: _message,
              isChecked: _todofinish,
              id:_id,
            ));
          }else{
            _messages.add(ChatMessage(
              text: _message,
              isSentByUser: true,
            ));
          }
          
        });
        print(_message.toString());//デバッグ用
      }
    }
  }

  String _checkTodo() {
    if(_textEditingController.text.toLowerCase().substring(0,4) == "todo" && _textEditingController.text.length > 3){
      return "true";
    }else{
      return "false";
    }
  }

  //送信ボタン
  void _insert() async {
    // row to insert
    //データベースに登録
    print("これからデータベース登録");
    String _todostate = _checkTodo().toString();
    Map<String, dynamic> row = {
      DatabaseHelper.columnSender : "true",
      DatabaseHelper.columnTodo :_todostate,
      DatabaseHelper.columnTodofinish : 0,
      DatabaseHelper.columnMessage : _textEditingController.text.toString(), //送信テキスト
      DatabaseHelper.columnTime : DateTime.now().toString(),
    };
    final id = await dbHelper.insert(row);
    //print(_textEditingController.text);//デバッグ用
    print('登録しました。id: $id');
    _sendMessage(id,_checkTodo());//画面処理
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
      DatabaseHelper.columnSender   : "false",
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
        title: Text('Chat Page'),
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
                    _insert();//データベースに対する送信処理
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
class TodoMessage extends StatefulWidget {
  TodoMessage({required this.text,required this.isChecked,required this.id});//クラスを呼び出すときに引数を必要とする(辻)
  final String text;// チャットメッセージのテキスト
  final int isChecked;
  final int id;// チャットのid

  @override
  _TodoMessage createState() => _TodoMessage();
}

class _TodoMessage extends State<TodoMessage> {
  late bool checked;
  // DatabaseHelper クラスのインスタンス取得
  final dbHelper = DatabaseHelper.instance;

  @override
  
  void initState() {
    super.initState();
    print("initstate");
    if(widget.isChecked == 0){
      checked = false;
    }else{
      checked = true;
    }
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 子ウィジェットを左揃えにする
          children: [
            Row(
              children:[
                Checkbox(
                  value: checked, // チェックボックスの状態
                  onChanged: (value) {
                    // チェックボックスの状態が変更された時の処理
                    setState(() {
                      checked = value!;
                      _toggleCheckbox(widget.id,checked);
                      print("チェックボックス押された時の処理終わり");
                    });
                  },
                ),
                Text(
                  widget.text,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Text(
              "開始:2022-10-10-10:10:10"
              
            )
          ],
        )
      ),
    );
  }

    // todoのチェックボックスがチェックされたときの挙動
  void _toggleCheckbox(int id,_checked) async {
    //boolをデータベースに登録するとint型の0と1に変換される
    Database? db = await dbHelper.database;//データベース取得
    await db?.update(
      'my_table',
      {'todofinish':_checked},
      where: '_id=?',
      whereArgs: [id],
    );
  }

  Future<String> _getTodoStart(int id) async {
    Database? db = await dbHelper.database;//データベース取得
    final List<Map<String, dynamic>>? todoStartTime = await db?.query(
      'my_table',
      columns: ['time'], // 取得したいカラムのリスト
      where: '_id = ?',
      whereArgs: [id],
    );

    print(todoStartTime);

    String result = "0";

    return result ;
  }
}