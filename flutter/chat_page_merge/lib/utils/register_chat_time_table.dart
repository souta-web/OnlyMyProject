import 'database_helper.dart';

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

  // チャットタイムテーブルに登録を行う関数
  void registerChatTimeTableFunc(bool isTodo) async {
    // データベースに登録
    print('これからチャットタイムテーブルに登録');
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    final List<Map<String, dynamic>> chatRow =
        (await dbHelper.queryAllRows_chat_table());
    print('チャットテーブルから取得したデータ: $chatRow');

    await insertChatTimeTable();

    print('チャットテーブルのデータ：$chatRow');

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_chat_time_table();
    print('チャットタイムテーブルの全てのデータを照会しました。');
    allRows.forEach(print);
  }

  // 新しいchatIdでchat_time_tableにデータを挿入する関数
  Future<void> insertChatTimeTable() async {
    // データベースヘルパーのインスタンス生成
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    // チャットタイムテーブルのデータを照会するリスト
    final List<Map<String, dynamic>> chatRow = await dbHelper.queryAllRows_chat_time_table();

    // チャットタイムテーブルとチャットテーブルを紐づけるIDを定義
    late int chatId = chatRow.isNotEmpty ? (chatRow.last['_chat_time_id'] ?? 0) + 1 : 1;

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
  }
}
