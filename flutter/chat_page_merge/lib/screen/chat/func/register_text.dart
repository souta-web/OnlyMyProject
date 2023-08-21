import 'package:flutter/material.dart';
import '/utils/database_helper.dart';
import '/widget/chat_fukidashi.dart';

// テキストをデータベースに登録する
class RegisterText {
  // テキストフィールドに入力されたテキストをデータベースに登録する
  static void _registerTextToDatabase(String text, int sender) async {
    // テキストがnullでないかをチェック
    if (text.isNotEmpty) {
      // DatabaseHelperのインスタンス生成
      final DatabaseHelper dbHelper = DatabaseHelper.instance;
      String time = DateTime.now().toIso8601String();
      // 登録するデータの行を生成
      Map<String, dynamic> row = { 
        DatabaseHelper.columnChatSender: sender, // 送信者情報: 0 (0=User, 1=AI)
        DatabaseHelper.columnChatTodo:
            'false', // todoかどうか: false (false=message)
        DatabaseHelper.columnChatMessage: text, // チャットのテキスト
        DatabaseHelper.columnChatTime: time, // 送信時間
        DatabaseHelper.columnChatActionId: 0,
      };

      // データベースに行を追加する
      await dbHelper.insert_chat_table(row);
    }
  }

  // メッセージの送信を処理するメソッド
  static void handLeSubmitted(String text, List<dynamic> messages,
      TextEditingController controller) async {
    // テキストをデータベースに登録して返答メッセージを表示する
    _registerAndShowReplyMessage(text, messages, controller);

    // 新しいチャットメッセージを作成する
    ChatMessage userMessage = ChatMessage(
        text: text, isSentByUser: true); // isSentByUserがtrueはユーザーが送信する

    // テキスト入力をクリアする
    controller.clear();

    // 送信メッセージを追加
    messages.add(userMessage);

    String replyText = "データが登録されました"; // 返信メッセージの内容
    print(replyText);
    ChatMessage replyMessage = ChatMessage(
        text: replyText, isSentByUser: false); // isSentUserがfalseはAIが返信する

    messages.add(replyMessage); // 返答メッセージを追加

    // テキストをデータベースに永続化
    await _saveChatMessages(messages);
  }

  // 新しいメッセージをデータベースから読み込む
  static Future<void> _loadChatMessages(List<dynamic> messages) async {
    // databasehelperのインスタンス生成
    final dbHelper = DatabaseHelper.instance;
    final chats = await dbHelper.queryAllRows_chat_table();

    messages.clear(); // メッセージをクリアする
    chats.forEach((chat) {
      messages.add(ChatMessage(
          text: chat[DatabaseHelper.columnChatMessage],
          isSentByUser: chat[DatabaseHelper.columnChatSender] == 0));
    });
  }

  // テキストをデータベースに登録し、返答メッセージを表示するメソッド
  static _registerAndShowReplyMessage(String text, List<dynamic> messages,
      TextEditingController controller) async {
    final dbHelper = DatabaseHelper.instance;
    final chats = await dbHelper.queryAllRows_chat_table();

    // テキストをデータベースに登録
    _registerTextToDatabase(text, 0); // 0は送信者を'ユーザー'とする

    if (controller.text.isNotEmpty) {
      // テキストフィールドに値が入っているかチェック
      // 新しいチャットメッセージを作成する
      ChatMessage replyMessage =
          ChatMessage(text: text, isSentByUser: false); // 送信側のメッセージ
      // チャットメッセージをリストの先頭に追加する
      messages.add(replyMessage);

      // テキストをクリアする
      controller.clear();

      // 新しいメッセージを読み込む
      await _loadChatMessages(messages);
      // メッセージ表示を更新
      messages.clear();
      messages.addAll(chats);
    }
  }

  // チャットメッセージを永続化するメソッド
  static Future<void> _saveChatMessages(List<dynamic> messages) async {
    final db = DatabaseHelper.instance;
    String time = DateTime.now().toIso8601String();
    for (var message in messages) {
      // messageの型がChatMessageであることを前提としてキャストする
      if (message is ChatMessage) {
        int sender = message.isSentByUser ? 0 : 1; // 送信者の判定
        Map<String, dynamic> row = {
          DatabaseHelper.columnChatSender: sender, // 送信者情報: 0 (0=User, 1=AI)
          DatabaseHelper.columnChatTodo:
              'false', // todoかどうか: false (false=message)
          DatabaseHelper.columnChatMessage: message.text, // チャットのテキスト
          DatabaseHelper.columnChatTime: time, // 送信時間
          DatabaseHelper.columnChatActionId: 0,
        };
        await db.insert_chat_table(row);
      }
    }
  }
}
