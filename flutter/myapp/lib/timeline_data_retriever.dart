import 'dart:async';
import 'database_helper.dart';
import 'package:sqflite/sqflite.dart';

// 動作確認はPrintで出力
// タイムライン表示用のウィジェットに引き渡すためのデータを取得するクラス
class TimeLineDataRetriever {
  // データベースからアクションテーブルのカラムデータを取得する非同期メソッド
  Future<List<Map<String, dynamic>>> getActionData() async {

    // DatabaseHelperのインスタンス生成
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    // dbhelperインスタンスを使用して、データベースを取得しdb変数に格納
    // db変数はnullableな変数として定義
    Database? db = await dbHelper.database;

    // dbがnullでないこと確認したうえで、dbを使用してアクションテーブルの
    // 指定したカラムにデータを取得している
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
