import 'utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

// タイムライン表示用のウィジェットに引き渡すためのデータを取得する
class TimeLineListCard {
  // データを取得するメソッド
  Future<List<Map<String, dynamic>>> getActionData() async {
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

  // 以下は実装例です。記述するとエラーが出るのでコメントアウトで残しておきます
  // GetDatabase database = GetDatabase();
  // List<Map<String, dynamic>> actionData = await database.getActionData();

  // アクションデータの表示例
  // for (var record in actionData) {
  //   print('Action Name: ${record[DatabaseHelper.columnActionName]}');
  //   print('Description: ${record[DatabaseHelper.columnActionNotes]}');
  //   print('Main Tag: ${record[DatabaseHelper.columnActionMainTag]}');
  //   print('Sub Tag: ${record[DatabaseHelper.columnActionSubTag]}');
  //   print('Status: ${record[DatabaseHelper.columnActionState]}');
  //   print('ActionScore: ${record[DatabaseHelper.columnActionScore]}');
  //   print('------------------');
  // }
}
