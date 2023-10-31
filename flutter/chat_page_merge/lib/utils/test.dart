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
    print('これからメディアデータベースに登録');
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    // mediaListがnullでないことを確認
    if (mediaList == null) {
      return; // nullの場合は何もしない
    }

    late Map<String, dynamic> mediaRow; // lateでグローバル変数としてmediaRowを定義
    // 1.最初にmediaTableNameとTableIdを登録
    // 2.画像自体の登録は画像の更新処理として行う
    mediaRow = {
      DatabaseHelper.columnMediaTableName:
          mediaTableName, // どのテーブルの画像が登録されているかを記録する
      DatabaseHelper.columnMediaTableId:
          mediaTableId, // フィールドに登録される画像が↑のテーブルのどのidにあるかを記録する
    };

    await dbHelper.insert_media_table(mediaRow);

    late int i;
    for (i = 0; i < mediaList!.length; i++) {
      final Uint8List imageData = mediaList![i]; // リストから画像を取得

      print('i= $i');
      // 画像が空でないことを確認
      if (imageData.isEmpty) {
        return;
      }

      // 画像のインデックスに応じて適切なデータベースカラムに画像を追加
      switch (i) {
        case 0:
          mediaRow[DatabaseHelper.columnMedia01] = imageData;
          print(mediaRow[DatabaseHelper.columnMedia01]);
          print('case 0:');
          break;
        case 1:
          mediaRow[DatabaseHelper.columnMedia02] = imageData;
          print(mediaRow[DatabaseHelper.columnMedia02]);
          print('case 1:');
          break;
        case 2:
          mediaRow[DatabaseHelper.columnMedia03] = imageData;
          print(mediaRow[DatabaseHelper.columnMedia03]);
          print('case 2:');
          break;
        case 3:
          mediaRow[DatabaseHelper.columnMedia04] = imageData;
          print(mediaRow[DatabaseHelper.columnMedia04]);
          print('case 3:');
          break;
      }
    }
    await dbHelper.update_media_table(mediaRow, i);
    print('メディアデータが個別に登録されました');
    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_media_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
