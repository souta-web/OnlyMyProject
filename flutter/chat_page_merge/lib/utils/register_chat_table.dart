import 'database_helper.dart';

class RegisterChatTable {
  final int? chatId; //idはデータ登録時に自動で割り当てられるため、引数で渡す必要は基本的にはない
  final String? chatSender;
  final String? chatTodo;
  final String? chatMessage;

  final String? chatActionId;
  final int? chatMessageId;

  RegisterChatTable(
      {this.chatId,
      this.chatSender,
      this.chatTodo,
      this.chatMessage,
      this.chatActionId,
      this.chatMessageId,
  });

  void registerChatTableFunc() async {
    // row to insert
    //データベースに登録
    print("これからチャットテーブルに登録");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnChatId: chatId,
      DatabaseHelper.columnChatSender: chatSender,
      DatabaseHelper.columnChatTodo: chatTodo,
      DatabaseHelper.columnChatMessage: chatMessage,
      DatabaseHelper.columnChatActionId: chatActionId,
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