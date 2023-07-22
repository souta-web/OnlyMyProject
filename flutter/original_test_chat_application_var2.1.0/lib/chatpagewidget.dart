import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'utils/database_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';


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
  TodoMessage({required this.text,required this.isChecked,required this.id,required this.media});//クラスを呼び出すときに引数を必要とする(辻)
  final String text;// チャットメッセージのテキスト
  final int isChecked;
  final int id;// チャットのid
  final Uint8List? media;//バイナリデータを受け取る

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
      child: GestureDetector(
        onLongPress: () {
        // 長押しされたときの処理を実行
        _MoveActionDetailPageProcess(widget.id,context);
        print("長押しされてるよ");
        },
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
              ),
              _draw_image(),
            ],
          )
        ),
      ),
    );
  }

    // todoのチェックボックスがチェックされたときの挙動
  void _toggleCheckbox(int id,_checked) async {
    //boolをデータベースに登録するとint型の0と1に変換される
    Database? db = await dbHelper.database;//データベース取得
    await db?.update(
      'action_table',
      {'action_state':_checked},
      where: '_action_id=?',
      whereArgs: [id],
    );
    if (_checked == true){
      _insertActionEndTime(id,_checked);
    }
  }

  void _insertActionEndTime(int id,_checked) async {
    Database? db = await dbHelper.database;//データベース取得
    await db?.update(
      'action_table',
      {'action_end':DateTime.now().toString()},
      where: '_action_id=?',
      whereArgs: [id],
    );
  }

  Future<String> _getTodoStart(int id) async {
    Database? db = await dbHelper.database;//データベース取得
    final List<Map<String, dynamic>>? todoStartTime = await db?.query(
      'chat_table',
      columns: ['chat_time'], // 取得したいカラムのリスト
      where: '_chat_id = ?',
      whereArgs: [id],
    );

    print(todoStartTime);

    String result = "0";

    return result ;
  }

  void _MoveActionDetailPageProcess(int action_id,BuildContext context) async {
    Database? db = await DatabaseHelper.instance.database;//データベース取得
    final List<Map<String, dynamic>>? result = await db?.query(
      'action_table', // テーブル名
      where: '_action_id = ?', // 条件式
      whereArgs: [action_id], // 条件の値
    );
    Navigator.pushNamed(
      context,
      '/actionEditPage',
      arguments:{'choice_record':result?[0]}//main.dartのonGenerateRouteに引数として渡す,型はMap<String, dynamic>
    );
  }

  Widget _draw_image() {
    if (widget.media != null) {
      final Uint8List _image = widget.media!;
      return Container(
        child: Image.memory(_image),
      );
    } else {
      return Container(
      );
    }
  }
}