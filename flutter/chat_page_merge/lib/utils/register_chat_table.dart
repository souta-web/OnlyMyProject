import 'database_helper.dart';
import 'text_formatter.dart';

class RegisterChatTable {
  final int? chatId; //idはデータ登録時に自動で割り当てられるため、引数で渡す必要は基本的にはない
  final String? chatSender;
  final String? chatTodo;
  final String? chatTodofinish;
  final String? chatMessage;
  final String? chatTime;
  final String? chatChannel;
  final String? chatActionId;

  // TextFormatterのインスタンス生成
  TextFormatter linkIdFormatter = TextFormatter();

  RegisterChatTable(
      {this.chatId,
      this.chatSender,
      this.chatTodo,
      this.chatTodofinish,
      this.chatMessage,
      this.chatTime,
      this.chatChannel,
      this.chatActionId});

  void registerChatTableFunc() async {
    // 送信時間を数値化してchat_action_idとaction_chat_idに登録
    final String chatActionLinkId =
        linkIdFormatter.returnChatActionLinkId(chatTime ?? "null");
    // row to insert
    //データベースに登録
    print("これからデータベース登録");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnChatId: chatId,
      DatabaseHelper.columnChatSender: chatSender,
      DatabaseHelper.columnChatTodo: chatTodo,
      DatabaseHelper.columnChatTodofinish: chatTodofinish,
      DatabaseHelper.columnChatMessage: chatMessage,
      DatabaseHelper.columnChatTime: chatTime,
      DatabaseHelper.columnChatChannel: chatChannel,
      DatabaseHelper.columnChatActionId: chatActionLinkId,
    };

    await dbHelper.insert_chat_table(row);

    //↓デバッグ用のデータ表示プログラム
    final List<Map<String, dynamic>> allRows = await dbHelper.queryAllRows_chat_table();
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