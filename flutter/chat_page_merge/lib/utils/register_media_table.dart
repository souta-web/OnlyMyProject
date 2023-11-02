import 'database_helper.dart';
import 'dart:typed_data';

// メディア登録用汎用クラス
class RegisterMediaTable {
  final String? mediaTableName; // どのテーブルの画像が保存されているかを記録する
  final int? mediaTableId; // フィールドに登録される画像が↑のテーブルのどのidにあるかを記録する
  final List<Uint8List>? mediaList; // 画像をリストとして管理
  // columnMedia01~04までの画像を登録する

  RegisterMediaTable({
    this.mediaTableName,
    this.mediaTableId,
    this.mediaList,
  });

  // メディア登録を行う関数
  void registerMediaTableFunc() async {
    // データベースに登録
    print('これからメディアデータベースに登録');
    final DatabaseHelper dbHelper =
        DatabaseHelper.instance; // DatabaseHelperのインスタンス生成

    late Map<String, dynamic> mediaRow; // lateでグローバル変数としてmediaRowを定義、
    // mediaRowの中にDatabaseHelper.columnMediaTableName,DatabaseHelper.columnMediaTableIdを設定

    mediaRow = {
      DatabaseHelper.columnMediaTableName:mediaTableName, // どのテーブルの画像が登録されているかを記録する
      DatabaseHelper.columnMediaTableId: mediaTableId, // フィールドに登録される画像が↑のテーブルのどのidにあるかを記録する
    };

    // 下記にはforまたはwhileで4回ループさせてmedia01～04までの画像データを個別に登録する処理を記述する
    // 4つの画像データを個別に登録
    late int i;
    for (i = 1; i < mediaList!.length; i++) {
      String columnName = 'media_0$i';
      Uint8List? mediaData = mediaList![i - 1];

      if (mediaData.isNotEmpty) {
        mediaRow[columnName] = mediaData;
      }
    }
    // 4枚画像を選択したとき、
    // ここでiの値が4になったからデータは登録されてるっぽい
    print('i = $i');

    await dbHelper.insert_media_table(mediaRow); // メディアテーブル登録関数の実行

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_media_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
