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

  // チャットタイムテーブルに登録を行う関数
  void registerChatTimeTableFunc(bool isTodo) async {
    // データベースに登録
    print('これからチャットタイムテーブルに登録');
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    late int setChatId;

    final List<Map<String, dynamic>> chatRow =
        await dbHelper.queryAllRows_chat_table();
    
    if (chatRow.isNotEmpty) {
      // データベースが存在する場合、SetChatIdとchatIdの値を同じにする
      setChatId = chatRow.first['_chat_id'];
    } else {
      // データベースが存在しない場合、SetChatIdに新しい値を挿入する
      setChatId = await dbHelper.insert_chat_table({'_chat_id': null}); // 適切な初期値を挿入する必要があります
    }

    final Map<String, dynamic> chatTimeRow = {
      DatabaseHelper.columnChatTimeId: chatTimeId,
      DatabaseHelper.columnSetChatId: setChatId,
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
    print('チャットタイムテーブルの全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
