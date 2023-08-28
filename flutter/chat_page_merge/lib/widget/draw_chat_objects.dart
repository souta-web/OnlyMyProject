import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';


class DrawChatObjects {

  // トグルボタンの状態によってオブジェクトを表示する
  void drawChatObjects(String chatText, List<dynamic> messages, TextEditingController controller) {
    ChatMessage userMessage = ChatMessage(text: chatText, isSentByUser: true); // 送信側のメッセージ

    // テキスト入力をクリアする
    controller.clear();

    // チャットメッセージをリストの先頭に追加
    messages.add(userMessage);
  }
}