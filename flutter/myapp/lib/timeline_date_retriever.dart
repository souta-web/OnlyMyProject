import 'dart:async';
import 'database_helper.dart';
import 'package:sqflite/sqflite.dart';

// 動作確認はPrintで出力
// タイムライン表示用のウィジェットに引き渡すためのデータを取得する
class TimeLineDataRetriever {
  // データを取得するメソッド
  Future<List<Map<String, dynamic>>> getActionData() async {
    // DatabaseHelperのインスタンス生成
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    Database? db = await dbHelper.database;
    return await db!.query(DatabaseHelper.action_table, columns: [
      DatabaseHelper.columnActionName, // アクション名
      DatabaseHelper.columnActionNotes, // 説明文
      DatabaseHelper.columnActionMainTag, // メインタグ
      DatabaseHelper.columnActionSubTag, // サブタグ
      DatabaseHelper.columnActionState, // 状態
      DatabaseHelper.columnActionScore, // 充実度
    ]);
  }
}
