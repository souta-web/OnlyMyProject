import 'database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

// タイムライン表示用のウィジェットに引き渡すためのデータを取得する
class GetDatabase {

  // データを取得するメソッド
  Future<List<Map<String, dynamic>>> getActionData() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    Database? db = await dbHelper.database;
    return await db!.query(DatabaseHelper.action_table, columns: [
      DatabaseHelper.columnActionName,  // アクション名
      DatabaseHelper.columnActionNotes, // 説明文
      DatabaseHelper.columnActionMainTag, // メインタグ
      DatabaseHelper.columnActionSubTag,  // サブタグ
      DatabaseHelper.columnActionState, // 状態
      DatabaseHelper.columnActionScore, // 充実度
    ]);
  }
}