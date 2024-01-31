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

    await insertTagSettingTable(dbHelper);

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_tag_setting_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }

  Future<Map<String, dynamic>> insertTagSettingTable(DatabaseHelper dbHelper) async {
    final List<Map<String, dynamic>> row =
        await dbHelper.queryAllRows_tag_setting_table();

    late int actionId = row.isNotEmpty ? (row.last['_tag_action_id'] ?? 0) + 1 : 1;
    late int tagId = row.isNotEmpty ? (row.last['_set_tag_id'] ?? 0) + 1 : 1;

    final Map<String, dynamic> tagSettingRow = {
      DatabaseHelper.columnTagActionId: actionId,
      DatabaseHelper.columnSetTagId: tagId,
      DatabaseHelper.columnMainTagFlag: mainTagFlag,
    };
    await dbHelper.insert_tag_setting_table(tagSettingRow);

    return tagSettingRow;
  }
}
