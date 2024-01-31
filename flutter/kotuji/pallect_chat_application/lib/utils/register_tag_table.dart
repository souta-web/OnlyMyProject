import 'database_helper.dart';

// タグテーブル登録汎用プログラム
class RegisterTagTable {
  final int? tagId;
  final String? tagName;
  final int? tagColor;
  final String? tagIcon;

  RegisterTagTable({
    this.tagId,
    this.tagName,
    this.tagColor,
    this.tagIcon,
  });

  void registerTagTableFunc() async {
    // データベースに登録
    print('これからタグテーブルに登録');
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    final Map<String, dynamic> tagRow = {
      DatabaseHelper.columnTagId: tagId,
      DatabaseHelper.columnTagName: tagName,
      DatabaseHelper.columnTagColor: tagColor,
      DatabaseHelper.columnTagIcon: tagIcon,
    };

    await dbHelper.insert_tag_table(tagRow);

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows = await dbHelper.queryAllRows_tag_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
