import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'database_helper.dart';

// 検索ボタンの動作
class SearchDatabase {
  // 検索メソッド
  Future<void> search(String keyword) async {
    // データベースヘルパーのインスタンスを生成
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    // キーワードを小文字に変換
    keyword = keyword.toLowerCase();

    // データベースからチャットテーブルの一致するレコードを検索
    List<Map<String, dynamic>> chatRecords =
        await dbHelper.queryAllRows_chat_table();
    List<Map<String, dynamic>> matchedChatRecords = chatRecords
        .where((record) =>
            record[DatabaseHelper.columnChatId]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatSender]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatTodo]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatTodofinish]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatMessage]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatTime]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatChannel]
                .toString()
                .toLowerCase()
                .contains(keyword))
        .toList();

    // データベースからアクションテーブルの一致するレコードを検索
    List<Map<String, dynamic>> actionRecords =
        await dbHelper.queryAllRows_action_table();
    List<Map<String, dynamic>> matchedActionRecords = actionRecords
        .where((record) =>
            record[DatabaseHelper.columnActionId].toString().toLowerCase().contains(keyword) ||
            record[DatabaseHelper.columnActionName]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionStart]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionEnd]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionDuration]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionMessage]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionMedia]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionNotes]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionScore]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionState]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionPlace]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionMainTag]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionSubTag]
                .toString()
                .toLowerCase()
                .contains(keyword))
        .toList();

    // データベースからタグテーブルの一致するレコードを検索
    List<Map<String, dynamic>> tagRecords =
        await dbHelper.queryAllRows_tag_table();
    List<Map<String, dynamic>> matchedTagRecords = tagRecords
        .where((record) =>
            record[DatabaseHelper.columnTagName]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnTagColor]
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            record[DatabaseHelper.columnTagRegisteredActionName]
                .toString()
                .toLowerCase()
                .contains(keyword))
        .toList();

    // チャットテーブルの一致するレコードを出力
    print('Matched records in Chat_Table:');
    for (var record in matchedChatRecords) {
      print(record);
    }

    // アクションテーブルの一致するレコードを出力
    print('Matched records in Action_Table:');
    for (var record in matchedActionRecords) {
      print(record);
    }

    // タグテーブルの一致するレコードを出力
    print('Matched records in Tag_Table:');
    for (var record in matchedTagRecords) {
      print(record);
    }
  }
}
