import 'database_helper.dart';

// 登録されたデータを更新する汎用プログラム
class UpdateChatTable {
  final int chatId; //idはデータ登録時に自動で割り当てられるため、引数で渡す必要は基本的にはない
  final String? chatSender;
  final String? chatTodo;
  final String? chatTodofinish;
  final String? chatMessage;
  final String? chatTime;
  final String? chatChannel;
  final String? chatActionId;

  UpdateChatTable(
      {required this.chatId,
      this.chatSender,
      this.chatTodo,
      this.chatTodofinish,
      this.chatMessage,
      this.chatTime,
      this.chatChannel,
      this.chatActionId});

  // データの更新を行う関数
  void updateChatTableFunc() async {
    
    //データベースに更新
    print("これからデータベース更新");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnChatId: chatId,
      DatabaseHelper.columnChatSender: chatSender,
      DatabaseHelper.columnChatTodo: chatTodo,
      DatabaseHelper.columnChatTodofinish: chatTodofinish,
      DatabaseHelper.columnChatMessage: chatMessage,
      DatabaseHelper.columnChatTime: chatTime,
      DatabaseHelper.columnChatChannel: chatChannel,
      DatabaseHelper.columnChatActionId: chatActionId,
    };

    await dbHelper.update_chat_table(row, chatId);

    //↓デバッグ用のデータ表示プログラム
    final List<Map<String, dynamic>> allRows = await dbHelper.queryAllRows_chat_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}

/*
次のような形で呼び出すことができる
  UpdateChatTable UpdateChatTable = UpdateChatTable( //インスタンス化、引数渡し
    chatSender: 'John',
    chatMessage: 'Hello!',
  );

  UpdateChatTable.UpdateChatTableFunc(); //実際にデータベース登録
*/