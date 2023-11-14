import 'database_helper.dart';

// チャットタイムテーブル登録汎用クラス
class RegisterChatTimeTable {
  final int? chatTimeId;
  final int? chatId;
  final int? chatYear;
  final int? chatMonth;
  final int? chatDay;
  final int? chatHours;
  final int? chatMinutes;
  final int? chatSeconds;
  final double? lessChatSeconds;

  RegisterChatTimeTable({
    this.chatTimeId,
    this.chatId,
    this.chatYear,
    this.chatMonth,
    this.chatDay,
    this.chatHours,
    this.chatMinutes,
    this.chatSeconds,
    this.lessChatSeconds,
  });

  void registerChatTimeTableFunc() async {
    // データベースに登録
    print('これからチャットタイムテーブルに登録');
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    final Map<String, dynamic> chatTimeRow = {
      DatabaseHelper.columnChatTimeId: chatTimeId,
      DatabaseHelper.columnSetChatId: chatId,
      DatabaseHelper.columnChatYear: chatYear,
      DatabaseHelper.columnChatMonth: chatMonth,
      DatabaseHelper.columnChatDay: chatDay,
      DatabaseHelper.columnChatHours: chatHours,
      DatabaseHelper.columnChatMinutes: chatMinutes,
      DatabaseHelper.columnChatSeconds: chatSeconds,
      DatabaseHelper.columnLessChatSeconds: lessChatSeconds,
    };

    await dbHelper.insert_chat_time_table(chatTimeRow);

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_chat_time_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
