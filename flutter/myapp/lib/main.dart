import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // DatabaseHelper クラスのインスタンス取得
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLiteデモ'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              child: Text(
                '登録',
                style: TextStyle(fontSize: 35),
              ),
              onPressed: _insert,
            ),
            ElevatedButton(
              child: Text(
                '照会',
                style: TextStyle(fontSize: 35),
              ),
              onPressed: _query,
            ),
            ElevatedButton(
              child: Text(
                '更新',
                style: TextStyle(fontSize: 35),
              ),
              onPressed: _update,
            ),
            ElevatedButton(
              child: Text(
                '削除',
                style: TextStyle(fontSize: 35),
              ),
              onPressed: _delete,
            ),
          ],
        ),
      ),
    );
  }

  // // 登録ボタンクリック
  // void _insert() async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     // チャットテーブルデバッグ用
  //     DatabaseHelper.columnChatSender: '山田　ji郎',
  //     DatabaseHelper.columnChatTodo: 'true',
  //     DatabaseHelper.columnChatTodofinish: 'true',
  //     DatabaseHelper.columnChatMessage: 'Test Message',
  //     DatabaseHelper.columnChatTime: '10:10',
  //     DatabaseHelper.columnChatChannel: '1'
  //   };
  //   final id = await dbHelper.insert_chat_table(row);
  //   print('登録しました。id: $id');
  // }

  // // 照会ボタンクリック
  // void _query() async {
  //   final allRows = await dbHelper.queryAllRows_chat_table();
  //   print('全てのデータを照会しました。');
  //   allRows.forEach(print);
  // }

  // // 更新ボタンクリック
  // void _update() async {
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnChatId: 1,
  //     DatabaseHelper.columnChatSender: '山田　鼻子',
  //     DatabaseHelper.columnChatTodo: 'false',
  //     DatabaseHelper.columnChatTodofinish: 'false',
  //     DatabaseHelper.columnChatMessage: 'Test Message2',
  //     DatabaseHelper.columnChatTime: '10:15',
  //     DatabaseHelper.columnChatChannel: '2'
  //   };
  //   final rowsAffected = await dbHelper.update_chat_table(row, 1);
  //   print('更新しました。 ID：$rowsAffected ');
  // }

  // // 削除ボタンクリック
  // void _delete() async {
  //   final id = await dbHelper.queryRowCount_chat_table();
  //   final rowsDeleted = await dbHelper.delete_chat_table(id!);
  //   print('削除しました。 $rowsDeleted ID: $id');
  // }

  // 登録ボタンクリック
  // void _insert() async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     // アクションテーブルデバッグ用
  //     DatabaseHelper.columnActionName: 'ゲーム',
  //     DatabaseHelper.columnActionStart: '8:00',
  //     DatabaseHelper.columnActionEnd: '9:00',
  //     DatabaseHelper.columnActionDuration: '1:00',
  //     DatabaseHelper.columnActionMessage: 'アクションを開始しました',
  //     DatabaseHelper.columnActionMedia: 'メディアです',
  //     DatabaseHelper.columnActionNotes: 'ゲームをしています',
  //     DatabaseHelper.columnActionScore: '5',
  //     DatabaseHelper.columnActionState: '0',
  //     DatabaseHelper.columnActionPlace: '自宅',
  //     DatabaseHelper.columnActionMainTag: '#遊び',
  //     DatabaseHelper.columnActionSubTag: '#趣味'
  //   };
  //   final id = await dbHelper.insert_action_table(row);
  //   print('登録しました。id: $id');
  // }

  // // 照会ボタンクリック
  // void _query() async {
  //   final allRows = await dbHelper.queryAllRows_action_table();
  //   print('全てのデータを照会しました。');
  //   allRows.forEach(print);
  // }

  // // 更新ボタンクリック
  // void _update() async {
  //
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnActionId: 1,
  //     DatabaseHelper.columnActionName: 'マラソン',
  //     DatabaseHelper.columnActionStart: '10:00',
  //     DatabaseHelper.columnActionEnd: '12:00',
  //     DatabaseHelper.columnActionDuration: '2:00',
  //     DatabaseHelper.columnActionMessage: 'アクションを開始しました',
  //     DatabaseHelper.columnActionMedia: 'マラソンメディアです',
  //     DatabaseHelper.columnActionNotes: '走っています',
  //     DatabaseHelper.columnActionScore: '10',
  //     DatabaseHelper.columnActionState: '1',
  //     DatabaseHelper.columnActionPlace: '公園',
  //     DatabaseHelper.columnActionMainTag: '#運動',
  //     DatabaseHelper.columnActionSubTag: '#トレーニング'
  //   };
  //   final rowsAffected = await dbHelper.update_action_table(row, 1);
  //   print('更新しました。 ID：$rowsAffected ');
  // }

  // // 削除ボタンクリック
  // void _delete() async {
  //   final id = await dbHelper.queryRowCount_action_table();
  //   final rowsDeleted = await dbHelper.delete_action_table(id!);
  //   print('削除しました。 $rowsDeleted ID: $id');
  // }

  // バグってるやつ
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      // タグテーブルデバッグ用
      DatabaseHelper.columnTagName: 'ゲーム',
      DatabaseHelper.columnTagColor: '青',
      DatabaseHelper.columnTagRegisteredActionName: 'サマポケを攻略'
    };
    final id = await dbHelper.insert_tag_table(row);
    print('登録しました。ID: $id');
  }

  // 照会ボタンクリック
  void _query() async {
    final allRows = await dbHelper.queryAllRows_tag_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }

  // 更新ボタンクリック
  void _update() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnTagId: 1,
      DatabaseHelper.columnTagName: '運動',
      DatabaseHelper.columnTagColor: '赤',
      DatabaseHelper.columnTagRegisteredActionName: '縄跳びをした'
    };
    final rowsAffected = await dbHelper.update_tag_table(row,1);
    print('更新しました。 ID：$rowsAffected ');
  }

  // 削除ボタンクリック
  void _delete() async {
    final id = await dbHelper.queryRowCount_tag_table();
    final rowsDeleted = await dbHelper.delete_tag_table(id!);
    print('削除しました。 $rowsDeleted ID: $id');
  }
}
