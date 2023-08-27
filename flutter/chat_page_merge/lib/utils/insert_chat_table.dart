import 'database_helper.dart';

//動作未チェック

class InsertChatTable{
  final int? chatId;
  final String? chatSender;
  final String? chatTodo;
  final int? chatTodofinish;
  final String? chatMessage;
  final String? chatTime;
  final String? chatChannel;
  final int? chatActionId;

  InsertChatTable ({this.chatId,
                    this.chatSender,
                    this.chatTodo,
                    this.chatTodofinish,
                    this.chatMessage,
                    this.chatTime,
                    this.chatChannel,
                    this.chatActionId
                    });

  void _insert_chat_table() async {
    // row to insert
    //データベースに登録
    print("これからデータベース登録");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnChatId : chatId,
      DatabaseHelper.columnChatSender : chatSender,
      DatabaseHelper.columnChatTodo : chatTodo,
      DatabaseHelper.columnChatTodofinish : chatTodofinish,
      DatabaseHelper.columnChatMessage : chatMessage,
      DatabaseHelper.columnChatTime : chatTime,
      DatabaseHelper.columnChatChannel : chatChannel,
      DatabaseHelper.columnChatActionId : chatActionId,

    };

    await dbHelper.insert_chat_table(row);
  }
}

/*
次のような形で呼び出すことができる
  InsertChatTable chatTable = InsertChatTable( //インスタンス化、引数渡し
    chatId: 1,
    chatSender: 'John',
    chatMessage: 'Hello!',
  );

  chatTable.insertChatTable(); //実際にデータベース登録
*/