import 'database_helper.dart';
import 'dart:typed_data';

// メディア登録用汎用クラス
class RegisterMediaTable {
  final int? mediaId; // メディアID
  final Uint8List? media; // メディアを管理
  final int? mediaChatId; // 添付メッセージID
  final int? linkActionId; // 関連アクションID

  RegisterMediaTable({
    this.mediaId,
    this.media,
    this.mediaChatId,
    this.linkActionId,
  });

  // メディア登録を行う関数
  void registerMediaTableFunc() async {
    // データベースに登録
    print('これからメディアテーブルに登録');
    final DatabaseHelper dbHelper =
        DatabaseHelper.instance; // DatabaseHelperのインスタンス生成

    await insertMediaTable();

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_media_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }

  Future<Map<String, dynamic>> insertMediaTable() async {
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    final List<Map<String, dynamic>> row =
        await dbHelper.queryAllRows_media_table();

    late int mediaChatId =
        row.isNotEmpty ? (row.last['_media_chat_id'] ?? 0) + 1 : 1;
    late int linkActionId =
        row.isNotEmpty ? (row.last['_link_action_id'] ?? 0) + 1 : 1;

    final Map<String, dynamic> mediaRow = {
      DatabaseHelper.columnMediaId: mediaId,
      DatabaseHelper.columnMedia: media,
      DatabaseHelper.columnMediaChatId: mediaChatId,
      DatabaseHelper.columnLinkActionId: linkActionId,
    };

    print('$mediaChatId');
    print('$linkActionId');
    await dbHelper.insert_media_table(mediaRow); // メディアテーブル登録関数の実行
    return mediaRow;
  }
}
