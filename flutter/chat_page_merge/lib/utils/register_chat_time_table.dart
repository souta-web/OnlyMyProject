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
        await dbHelper.queryAllRows_chat_table();
    print('チャットテーブルから取得したデータ: $chatRow[$chatId]');

    late int chatIdFromChatTable; // 初期値として 1 を設定

    if (chatRow.isNotEmpty) {
      // チャットテーブルから最新のデータを取得
      chatRow.sort((a, b) => b['_chat_id'].compareTo(a['_chat_id']));
      chatIdFromChatTable = chatRow.last['_chat_id'];
    } else {
      chatIdFromChatTable = 1;
    }

    final Map<String, dynamic> chatTimeRow = {
      DatabaseHelper.columnChatTimeId: chatTimeId,
      DatabaseHelper.columnSetChatId: chatIdFromChatTable,
      DatabaseHelper.columnChatYear: chatYear,
      DatabaseHelper.columnChatMonth: chatMonth,
      DatabaseHelper.columnChatDay: chatDay,
      DatabaseHelper.columnChatHours: chatHours,
      DatabaseHelper.columnChatMinutes: chatMinutes,
      DatabaseHelper.columnChatSeconds: chatSeconds,
      DatabaseHelper.columnLessChatSeconds: lessChatSeconds,
    };

    await dbHelper.insert_chat_time_table(chatTimeRow);

    print('チャットテーブルのデータ：$chatRow');

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_chat_time_table();
    print('チャットタイムテーブルの全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
