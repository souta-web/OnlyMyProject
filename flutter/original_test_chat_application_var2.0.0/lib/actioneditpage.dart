import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'package:sqflite/sqflite.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アクション編集'),
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
                  decoration: InputDecoration(
                  hintText: _getColumnData('action_score'),
                  ),
                  maxLines: null,
                ),
              ),
            ),
            _drawHorizontalLine(),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
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

  String _getColumnData(column_key){
    if (widget.action_table_alldata_editpage?[column_key] != null) {
      return widget.action_table_alldata_editpage?[column_key].toString() ?? "エラーが発生しました。";
    }
    return 'データがありません';
  }

  void _updateActionTable() async {
    // DatabaseHelper クラスのインスタンス取得
    final dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnActionName   : _textEditingController_title.toString(),
      DatabaseHelper.columnActionScore  : int.parse(_textEditingController_score.toString()),
      DatabaseHelper.columnActionNotes  : _textEditingController_notes.toString(),
    };
    final rowsAffected = await dbHelper.update_action_table(row);
    print('更新しました。 ID：$rowsAffected ');
  }
}
