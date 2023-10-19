import 'database_helper.dart';
import 'dart:typed_data';

// メディア登録用汎用クラス
class RegisterMediaTable {
  final String? mediaTableName;
  final int? mediaTableId;
  final List<Uint8List>? mediaList; // 画像をリストとして管理
  RegisterMediaTable({
    this.mediaTableName,
    this.mediaTableId,
    this.mediaList,
  });

  // メディア登録を行う
  void registerMediaTableFunc() async {
    // データベースに登録
    print('これからデータベースに登録');
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    // mediaListがnullでないことを確認
    if (mediaList == null) {
      return; // nullの場合は何もしない
    }

    for (int i = 0; i < mediaList!.length; i++) {
      final Uint8List imageData = mediaList![i];  // リストから画像を取得

      // 画像が空でないことを確認
      if (imageData.isNotEmpty) {
        final Map<String, dynamic> mediaRow = {
          DatabaseHelper.columnMediaTableName: mediaTableName, // どのテーブルの画像が登録されているかを記録する
          DatabaseHelper.columnMediaTableId: mediaTableId, // フィールドに登録される画像が↑のテーブルのどのidにあるかを記録する
          'media_column_index': i, // 画像のインデックスを追加
        };
        
        // 画像のインデックスに応じて適切なデータベースカラムに画像を追加
        switch (i) {
          case 0:
            mediaRow[DatabaseHelper.columnMedia01] = imageData;
            break;
          case 1:
            mediaRow[DatabaseHelper.columnMedia02] = imageData;
            break;
          case 2:
            mediaRow[DatabaseHelper.columnMedia03] = imageData;
            break;
          case 3:
            mediaRow[DatabaseHelper.columnMedia04] = imageData;
            break;
        }
        await dbHelper.insert_media_table(mediaRow);
        print('メディアデータが個別に登録されました');
      }
    }

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_media_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
