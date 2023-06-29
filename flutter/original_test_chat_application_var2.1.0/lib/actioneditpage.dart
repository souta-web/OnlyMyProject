import 'dart:ffi';

import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'actiondetailpage.dart';

class ActionEditPage extends StatefulWidget {
  final Map<String, dynamic>? action_table_alldata_editpage;

  ActionEditPage({required this.action_table_alldata_editpage});
  @override
  _ActionEditPage createState() => _ActionEditPage();
}

class _ActionEditPage extends State<ActionEditPage> {

  final double field1FontSize= 30.0;
  final double field2FontSize= 16.0;
  final double field3FontSize= 16.0;
  final double field4FontSize= 16.0;
  final double field5FontSize= 16.0;

  //テキストコントローラーの作成。テキストフィールドの値はこれで取得することができる
  final TextEditingController _textEditingController_title = TextEditingController();
  final TextEditingController _textEditingController_score = TextEditingController();
  final TextEditingController _textEditingController_notes = TextEditingController();

  List<Map<String, dynamic>> AllTextFieldHistry = []; //テキストフィールドの変更を保持するためのリスト宣言 

  @override

  void initState() {
    super.initState();
    // 初期化の処理をここに記述する
    _textEditingController_title.text = _getColumnData('action_name');
    _textEditingController_score.text = _getColumnData('action_score').toString();
    _textEditingController_notes.text = _getColumnData('action_notes');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(
          //icon: Icon(Icons.arrow_back),
          //onPressed: () {
            //_moveActionDetailPageProcess(context);
          //},
        //),
        title: Text('アクション編集'),
        //automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.grading),
            onPressed: () {
              // アクション詳細設定の処理
              _updateActionTable();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: _textEditingController_title,
                  decoration: InputDecoration(
                    hintText: _getColumnData('action_name'),
                  ),
                  maxLines: null,
                ),
              ),
            ),
            _drawHorizontalLine(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'タグ',
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: field2FontSize),
                ),
              ),
            ),
            _drawHorizontalLine(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'start:' + _getColumnData('action_start'),
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: field3FontSize),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'start:' + _getColumnData('action_end'),
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: field3FontSize),
                ),
              ),
            ),
            _drawHorizontalLine(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _textEditingController_score,
                  decoration: InputDecoration(
                  hintText: _getColumnData('action_score').toString(),
                  ),
                  maxLines: null,
                ),
              ),
            ),
            _drawHorizontalLine(),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                controller: _textEditingController_notes,
                decoration: InputDecoration(
                  hintText: _getColumnData('action_notes'),
                ),
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 0),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.undo),
            label: 'undo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.redo),
            label: 'redo',
          ),
        
        ],
        // バーが選択されたときの処理を追加する場合は、onTapプロパティに関数を設定します
        onTap: (int index) {
          // バーが選択されたときの処理を記述します
          // indexパラメータを使用して選択されたアイテムを識別できます
        },
      ),
    );
  }
  
  Widget _drawHorizontalLine() {
    return Divider(
      color: Colors.black, // 線の色を指定 (省略可能)
      height: 1.0, // 線の高さを指定 (省略可能)
      thickness: 1.5, // 線の太さを指定 (省略可能)
      indent: 0.0, // 線の開始位置からのオフセットを指定 (省略可能)
      endIndent: 0.0, // 線の終了位置からのオフセットを指定 (省略可能)
    );
  }

  dynamic _getColumnData(column_key){
    if (widget.action_table_alldata_editpage?[column_key] != null) {
      return widget.action_table_alldata_editpage?[column_key];//String?型を返すことがある
    }
    return '';
  }

  void _updateActionTable() async {
    // DatabaseHelper クラスのインスタンス取得
    final dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnActionName   : _textEditingController_title.text.toString(),
      DatabaseHelper.columnActionScore  : int.parse(_textEditingController_score.text),
      DatabaseHelper.columnActionNotes  : _textEditingController_notes.text.toString(),
    };
    final rowsAffected = await dbHelper.update_action_table(row,_getColumnData('_action_id'));
    print('更新しました。 ID：$rowsAffected ');
  }

  void _moveActionDetailPageProcess(BuildContext context) async {
    Database? db = await DatabaseHelper.instance.database;//データベース取得
    final int _id = widget.action_table_alldata_editpage?['_action_id'];
    final List<Map<String, dynamic>>? result = await db?.query(
      'action_table', // テーブル名
      where: '_action_id = ?', // 条件式
      whereArgs: [_id], // 条件の値
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ActionDetailPage(action_table_alldata_detailpage:result?[0])));

  }
}
