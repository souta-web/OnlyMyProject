import 'database_helper.dart';

class SearchDatabase {
  Future<void> search(String keyword) async {
    // データベースヘルパーのインスタンスを生成
    DatabaseHelper dbHelper = DatabaseHelper.instance;

    // データベースからチャットテーブルの一致するレコードを検索
    List<Map<String, dynamic>> chatRecords =
        await dbHelper.queryAllRows_chat_table();
    List<Map<String, dynamic>> matchedChatRecords = chatRecords
        .where((record) =>
            record[DatabaseHelper.columnChatId].toString().contains(keyword) ||
            record[DatabaseHelper.columnChatSender]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatTodo]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatTodofinish]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatMessage]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatTime]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatChannel]
                .toString()
                .contains(keyword))
        .toList();

    // データベースからアクションテーブルの一致するレコードを検索
    List<Map<String, dynamic>> actionRecords =
        await dbHelper.queryAllRows_action_table();
    List<Map<String, dynamic>> matchedActionRecords = actionRecords
        .where((record) =>
            record[DatabaseHelper.columnActionId]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionName]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionStart]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionEnd]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionDuration]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionMessage]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionMedia]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionNotes]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionScore]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionState]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionPlace]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionMainTag]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionSubTag]
                .toString()
                .contains(keyword))
        .toList();

    // データベースからタグテーブルの一致するレコードを検索
    List<Map<String, dynamic>> tagRecords =
        await dbHelper.queryAllRows_tag_table();
    List<Map<String, dynamic>> matchedTagRecords = tagRecords
        .where((record) =>
            record[DatabaseHelper.columnTagName].toString().contains(keyword) ||
            record[DatabaseHelper.columnTagColor]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnTagRegisteredActionName]
                .toString()
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
