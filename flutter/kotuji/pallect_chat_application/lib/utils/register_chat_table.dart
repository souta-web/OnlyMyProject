import 'database_helper.dart';

class RegisterChatTable {
  final int? chatId; //idはデータ登録時に自動で割り当てられるため、引数で渡す必要は基本的にはない
  final String? chatSender; // 送信者
  final String? chatTodo; // 送信モード
  final String? chatMessage; // メッセージ内容
  final int? chatMessageId; // 送信先メッセージID

  RegisterChatTable({
    this.chatId,
    this.chatSender,
    this.chatTodo,
    this.chatMessage,
    this.chatMessageId,
  });

  void registerChatTableFunc() async {
    // row to insert
    //データベースに登録
    print("これからチャットテーブルに登録");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    final List<Map<String, dynamic>> chatRows =
       await dbHelper.queryAllRows_chat_table();

    late int chatMessageId = chatRows.isNotEmpty ? (chatRows.last['chat_message_id'] ?? 0) + 1 : 1;

    Map<String, dynamic> row = {
      DatabaseHelper.columnChatId: chatId,
      DatabaseHelper.columnChatSender: chatSender,
      DatabaseHelper.columnChatTodo: chatTodo,
      DatabaseHelper.columnChatMessage: chatMessage,
      DatabaseHelper.columnChatMessageId: chatMessageId,
    };

    await dbHelper.insert_chat_table(row);

    //↓デバッグ用のデータ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_chat_table();
    print('チャットテーブルから全てのデータを照会しました。');
    allRows.forEach(print);
  }
}

/*
次のような形で呼び出すことができる
  RegisterChatTable registerChatTable = RegisterChatTable( //インスタンス化、引数渡し
    chatSender: 'John',
    chatMessage: 'Hello!',
  );

  registerChatTable.registerChatTableFunc(); //実際にデータベース登録
*/