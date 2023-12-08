import 'database_helper.dart';

// チャットタイムテーブル登録汎用クラス
class RegisterChatTimeTable {
  final int? chatTimeId; // チャットタイムID
  final int? chatId; // チャットID
  final int? chatYear; // 年
  final int? chatMonth; // 月
  final int? chatDay; // 日
  final int? chatHours; // 時
  final int? chatMinutes; // 分
  final int? chatSeconds; // 秒
  final double? lessChatSeconds; // 秒未満

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

    // チャットテーブルから有効なチャットIDを取得
    final List<Map<String, dynamic>> chatRows =
        await dbHelper.queryAllRows_chat_table();
    if (chatRows.isEmpty) return;

    // ここでチャットIDを取得
    final int? chatId = chatRows.first['_chat_id'];   

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
