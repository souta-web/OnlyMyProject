import '/utils/database_helper.dart';

// テキストをデータベースに登録する
class RegisterText {
  // テキストフィールドに入力されたテキストをデータベースに登録する
  static void registerTextToDatabase(String text, int seder) async {

    // テキストがnullでないかをチェック
    if (text.isNotEmpty) {

      // DatabaseHelperのインスタンス生成
      final DatabaseHelper dbHelper = DatabaseHelper.instance;
      // 登録するデータの行を生成
      Map<String, dynamic> row = {
        DatabaseHelper.columnChatSender: 0, // 送信者情報: 0 (0=User, 1=AI)
        DatabaseHelper.columnChatTodo: 'false', // todoかどうか: false (false=message)
        DatabaseHelper.columnChatMessage: text, // チャットのテキスト
        DatabaseHelper.columnChatTime: DateTime.now().toIso8601String(), // 送信時間
        DatabaseHelper.columnChatChannel: 'default', // チャットチャンネル（適宜変更）
      };

      // データベースに行を追加する
      await dbHelper.insert_chat_table(row);
    }
  }
}
