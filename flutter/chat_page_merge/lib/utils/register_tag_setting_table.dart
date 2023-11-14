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

    final Map<String, dynamic> tagRow = {
      DatabaseHelper.columnTagActionId: actionId,
      DatabaseHelper.columnSetTagId: tagId,
      DatabaseHelper.columnMainTagFlag: mainTagFlag,
    };

    await dbHelper.insert_tag_setting_table(tagRow);

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows = await dbHelper.queryAllRows_tag_setting_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
