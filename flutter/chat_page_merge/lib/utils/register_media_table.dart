import 'database_helper.dart';
import 'dart:typed_data';

// メディア登録用汎用クラス
class RegisterMediaTable {
  final String? mediaTableName;
  final int? mediaTableId;
  late Uint8List? media01;
  late Uint8List? media02;
  late Uint8List? media03;
  late Uint8List? media04;

  RegisterMediaTable(
    {this.mediaTableName,
    this.mediaTableId,
    this.media01,
    this.media02,
    this.media03,
    this.media04});

  // メディア登録を行う
  void registerMediaTableFunc() async {
    // データベースに登録
    print('これからデータベースに登録');
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    // バイナリデータをバイト配列に変換
    final Uint8List? media01Bytes = media01 != null ? Uint8List.fromList(media01!) : null;
    final Uint8List? media02Bytes = media02 != null ? Uint8List.fromList(media02!) : null;
    final Uint8List? media03Bytes = media03 != null ? Uint8List.fromList(media03!) : null;
    final Uint8List? media04Bytes = media04 != null ? Uint8List.fromList(media04!) : null;

    final Map<String, dynamic> mediaRow = {
      DatabaseHelper.columnMediaTableName: mediaTableName, // どのテーブルの画像が登録されているかを記録する
      DatabaseHelper.columnMediaTableId: mediaTableId, // フィールドに登録される画像が↑のテーブルのどのidにあるかを記録する
      DatabaseHelper.columnMedia01: media01Bytes, // メディア保存用カラム
      DatabaseHelper.columnMedia02: media02Bytes, // メディア保存用カラム
      DatabaseHelper.columnMedia03: media03Bytes, // メディア保存用カラム
      DatabaseHelper.columnMedia04: media04Bytes, // メディア保存用カラム
    };

    await dbHelper.insert_media_table(mediaRow);

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows = await dbHelper.queryAllRows_media_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
