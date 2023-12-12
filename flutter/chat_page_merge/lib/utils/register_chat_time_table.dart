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

  Future<int> insertChatTable(DatabaseHelper dbHelper, bool isTodo) async {
    late int? chatId;

    // チャットテーブルから有効なチャットIDを取得
    final List<Map<String, dynamic>> chatRows =
        await dbHelper.queryAllRows_chat_table();

    // チャットテーブルにデータが存在しない時
    if (chatRows.isEmpty) {
      final Map<String, dynamic> chatRow = {
        DatabaseHelper.columnChatId: 1,
        DatabaseHelper.columnChatSender: 'true',
        DatabaseHelper.columnChatTodo: isTodo.toString(),
      };
      await dbHelper.insert_chat_table(chatRow);
      chatId = 2; // 初回のチャットIDを設定
    } else {
      // 既存のチャットIDを取得
      chatId = chatRows.first['_chat_id'];
    }

    return chatId!;
  }

  void registerChatTimeTableFunc(bool isTodo) async {
    // データベースに登録
    print('これからチャットタイムテーブルに登録');
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    final int chatId = await insertChatTable(dbHelper, isTodo);

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

    try {
      await dbHelper.insert_chat_time_table(chatTimeRow);
    } catch (e) {
      // 修正: もし例外が発生した場合、新しい _chat_id を生成して再試行
      final int newChatId = await insertChatTable(dbHelper, isTodo);
      chatTimeRow[DatabaseHelper.columnSetChatId] = newChatId;
      await dbHelper.insert_chat_time_table(chatTimeRow);
    }

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_chat_time_table();
    print('チャットタイムテーブルの全てのデータを照会しました。');
    allRows.forEach(print);
  }
}
