import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';
import '/utils/register_chat_table.dart';
import '/utils/register_action_table.dart';


class DrawChatObjects {

  // トグルボタンがオンでもオフでもチャットは送信するのでメソッド化する
  void sendChatMessage(String chatText, List<dynamic> messages, TextEditingController controller) {
    ChatMessage userMessage = ChatMessage(text: chatText, isSentByUser: true); // 送信側のメッセージ

    // テキスト入力をクリアする
    controller.clear();

    // チャットメッセージをリストの先頭に追加
    messages.add(userMessage);
  }

  // テキストフィールドに入力されたメッセージをデータベースに登録する
  void _registerTextToDatabase(String text, int sender) {
    final dbHelper = DatabaseHelper.instance;

    // テキストがnullでないかをチェック
    if (text.isNotEmpty) {
      RegisterChatTable registerChatTable = RegisterChatTable( //インスタンス化、引数渡し
      chatSender: sender,
      chatMessage: text,
    );

    registerChatTable.registerChatTableFunc(); //実際にデータベース登録
    }
  }

  // 新しいメッセージをデータベースから読み込む
  void _loadChatMessages(List<dynamic> messages) async {
    // databasehelperのインスタンス生成
    final dbHelper = DatabaseHelper.instance;
    final chats = await dbHelper.queryAllRows_chat_table();

    messages.clear(); // メッセージをクリアする
        messages.add(ChatMessage(
        text: chat[DatabaseHelper.columnChatMessage],
        isSentByUser: chat[DatabaseHelper.columnChatSender] == 0,
      ));
    });
  }

  void _registerAndShowMessage(String text, List<dynamic> messages, TextEditingController controller) async {
    
    _registerTextToDatabase(text, 0); // ユーザーの登録

    \\
    if (controller.text.isNotEmpty) {
      // 新しいメッセージを読み込む
      await _loadMessages(messages);
    }
  }

  // 送信ボタンが押されたときに呼び出される
  void sendButtonPressed(String chatText, List<dynamic> messages, TextEditingController controller) {
    registerChatTable();
    if (_isTodo) {  // トグルボタンがオンの時だけ呼び出す
      RegisterActionTable registerActionTable = RegisterActionTable( //インスタンス化、引数渡し
      actionName: 'ゲーム',
      actionStart: '10:00',
    );

    registerActionTable.registerActionTableFunc(); //実際にデータベース登録
    }
    return drawChatObjects();  // この関数で吹き出しなどを作ってreturnで返す
  }
}