import 'database_helper.dart';

// タグ設定テーブル登録汎用プログラム
class RegisterTagSettingTable {
  final int? actionId;
  final int? tagId;
  final String? mainTagFlag;

  RegisterTagSettingTable({
    this.actionId,
    this.tagId,
    this.mainTagFlag,
  });

  void registerTagSettingTableFunc() async {
    // データベースに登録
    print('これからタグ設定テーブルに登録');
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    // アクションテーブルから有効なアクションIDを取得
    final List<Map<String, dynamic>> actionRows =
        await dbHelper.queryAllRows_action_table();
    print('アクションテーブルから取得したデータ: $actionRows');
    if (actionRows.isEmpty) {
      print('アクションテーブルに有効な行がありません');
      return;
    }
    final int actionId = actionRows[0]['_action_id'];

    // タグテーブルから有効なタグIDを取得
    final List<Map<String, dynamic>> tagRows =
        await dbHelper.queryAllRows_tag_table();
    print('タグテーブルから取得したデータ: $tagRows');
    if (tagRows.isEmpty) {
      print('タグテーブルに有効な行がありません');
      return;
    }
    final int tagId = tagRows[0]['_tag_id'];
    final Map<String, dynamic> tagSettingRow = {
      DatabaseHelper.columnTagActionId: actionId,
      DatabaseHelper.columnSetTagId: tagId,
      DatabaseHelper.columnMainTagFlag: mainTagFlag,
    };

    final int insertRowId =
        await dbHelper.insert_tag_setting_table(tagSettingRow);
    print('挿入された行のID: $insertRowId');

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_tag_setting_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
