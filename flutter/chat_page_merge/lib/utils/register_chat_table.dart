import 'database_helper.dart';

class RegisterChatTable {
  final int? chatId; //idはデータ登録時に自動で割り当てられるため、引数で渡す必要は基本的にはない
  final String? chatSender;
  final String? chatTodo;
  final String? chatMessage;
  final int? startActionId;
  final int? chatMessageId;

  RegisterChatTable({
    this.chatId,
    this.chatSender,
    this.chatTodo,
    this.chatMessage,
    this.startActionId,
    this.chatMessageId,
  });

  void registerChatTableFunc() async {
    // row to insert
    //データベースに登録
    print("これからチャットテーブルに登録");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    // アクションテーブルから有効なアクションIDを取得
    final List<Map<String, dynamic>> actionRows =
        await dbHelper.queryAllRows_action_table();
    if (actionRows.isEmpty) return;
    final int actionId = actionRows[0]['_action_id'];

    Map<String, dynamic> row = {
      DatabaseHelper.columnChatId: chatId,
      DatabaseHelper.columnChatSender: chatSender,
      DatabaseHelper.columnChatTodo: chatTodo,
      DatabaseHelper.columnChatMessage: chatMessage,
      DatabaseHelper.columnStartActionId: actionId,
      DatabaseHelper.columnChatMessageId: chatMessageId,
    };

    await dbHelper.insert_chat_table(row);

    //↓デバッグ用のデータ表示プログラム
    final List<Map<String, dynamic>> allRows =
        await dbHelper.queryAllRows_chat_table();
    print('全てのデータを照会しました。');
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