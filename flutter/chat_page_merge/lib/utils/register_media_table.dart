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

    if (mediaList == null) {
      return;
    }

    // バイナリデータをバイト配列に変換
    final List<Uint8List?> byteArrays = mediaList!.map((imageData) {
      if (imageData.isNotEmpty) {
        return Uint8List.fromList(imageData);
      } else {
        return null;
      }
    }).toList();

    final Uint8List? media01Bytes =
        byteArrays.length > 0 ? byteArrays[0] : null;
    final Uint8List? media02Bytes =
        byteArrays.length > 1 ? byteArrays[1] : null;
    final Uint8List? media03Bytes =
        byteArrays.length > 2 ? byteArrays[2] : null;
    final Uint8List? media04Bytes =
        byteArrays.length > 3 ? byteArrays[3] : null;
    final Map<String, dynamic> mediaRow = {
      DatabaseHelper.columnMediaTableName:
          mediaTableName, // どのテーブルの画像が登録されているかを記録する
      DatabaseHelper.columnMediaTableId:
          mediaTableId, // フィールドに登録される画像が↑のテーブルのどのidにあるかを記録する
      DatabaseHelper.columnMedia01: media01Bytes, // メディア保存用カラム
      DatabaseHelper.columnMedia02: media02Bytes, // メディア保存用カラム
      DatabaseHelper.columnMedia03: media03Bytes, // メディア保存用カラム
      DatabaseHelper.columnMedia04: media04Bytes, // メディア保存用カラム
    };

    await dbHelper.insert_media_table(mediaRow);

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_media_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);

    mediaRow.clear();
  }
}
