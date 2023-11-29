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

    // チャットテーブルから有効なチャットIDを取得
    final List<Map<String, dynamic>> chatRows =
        await dbHelper.queryAllRows_chat_table();
    if (chatRows.isEmpty) return;
    final int mediaChatId = chatRows[0]['_chat_id'];

    // アクションテーブルから有効なアクションID取得
    final List<Map<String, dynamic>> actionRows =
        await dbHelper.queryAllRows_action_table();
    if (actionRows.isEmpty) return;
    final int linkActionId = actionRows[0]['_action_id'];

    final Map<String, dynamic> mediaRow = {
      DatabaseHelper.columnMediaId: mediaId,
      DatabaseHelper.columnMedia: media,
      DatabaseHelper.columnMediaChatId: mediaChatId,
      DatabaseHelper.columnLinkActionId: linkActionId,
    };

    await dbHelper.insert_media_table(mediaRow); // メディアテーブル登録関数の実行

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_media_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
