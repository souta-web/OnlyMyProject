import 'package:sqflite/sqflite.dart';

void main() async {
  // データベースを開く
  final database =
      await openDatabase('my_database.db', version: 1, onCreate: (db, version) {
    // テーブルを作成する
    db.execute(
        'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, body TEXT)');
  });

  // 何かしらの処理を行う

  // データベースを閉じる
  await database.close();
}
