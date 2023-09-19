import 'database_helper.dart';
import 'dart:typed_data';

// メディア登録汎用クラス
class RegisterMediaTable {
  final int? mediaId;
  final Uint8List? media1;
  final Uint8List? media2;
  final Uint8List? media3;
  final Uint8List? media4;

  RegisterMediaTable({
    this.mediaId,
    this.media1,
    this.media2,
    this.media3,
    this.media4,
  });

  void registerMediaTableFunc() async {
    // データベースに登録
    print("これからデータベースに登録");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    final Map<String, dynamic> mediaRow = {
      DatabaseHelper.columnMediaId: mediaId,
      DatabaseHelper.columnMedia1: media1,
      DatabaseHelper.columnMedia2: media2,
      DatabaseHelper.columnMedia3: media3,
      DatabaseHelper.columnMedia4: media4,
    };

    await dbHelper.insert_media_table(mediaRow);
    print('登録終わりました!');

    // デバッグ表示用プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_media_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
