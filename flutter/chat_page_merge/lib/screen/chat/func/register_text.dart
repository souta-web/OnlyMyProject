import 'package:flutter/material.dart';
import '/utils/database_helper.dart';
import '/widget/chat_fukidashi.dart';

// テキストをデータベースに登録する
class RegisterText {

  // テキストフィールドに入力されたテキストをデータベースに登録する
  static void registerTextToDatabase(String text, int sender) async {
    
    // テキストがnullでないかをチェック
    if (text.isNotEmpty) {
      // DatabaseHelperのインスタンス生成
      final DatabaseHelper dbHelper = DatabaseHelper.instance;
      // 登録するデータの行を生成
      Map<String, dynamic> row = {
        DatabaseHelper.columnChatSender: sender, // 送信者情報: 0 (0=User, 1=AI)
        DatabaseHelper.columnChatTodo:
            'false', // todoかどうか: false (false=message)
        DatabaseHelper.columnChatMessage: text, // チャットのテキスト
        DatabaseHelper.columnChatTime: DateTime.now().toIso8601String(), // 送信時間
        DatabaseHelper.columnChatActionId: 0,
      };
      
      // データベースに行を追加する
      await dbHelper.insert_chat_table(row);
    }
  }

  // メッセージの送信を処理するメソッド
  static void handLeSubmitted(String text, List<dynamic> messages, TextEditingController controller) {
    // テキストをデータベースに登録して返答メッセージを表示する
    _registerAndShowReplyMessage(text, messages, controller);

    // 新しいチャットメッセージを作成する
    ChatMessage message =
        ChatMessage(text: text, isSentByUser: true); // 送信側のメッセージ
    // チャットメッセージをリストの先頭に追加する
    messages.insert(0, message);

    // テキスト入力をクリアする
    controller.clear();
  }

  // テキストをデータベースに登録し、返答メッセージを表示するメソッド
  static _registerAndShowReplyMessage(String text, List<dynamic> messages, TextEditingController controller) {

    // テキストをデータベースに登録
    registerTextToDatabase(text, 1); // 1は送信者を'ユーザー'とする
    if (controller.text.isNotEmpty) {
      // テキストフィールドに値が入っているかチェック
      // 新しいチャットメッセージを作成する
      ChatMessage message =
          ChatMessage(text: text, isSentByUser: true); // 送信側のメッセージ
      // チャットメッセージをリストの先頭に追加する
      messages.insert(0, message);

      // テキストをクリアする
      controller.clear();

      String replyText = "データが登録されました"; // 返信メッセージの内容
      print(replyText);
      ChatMessage replayMessage =
          ChatMessage(text: replyText, isSentByUser: false);
      messages.insert(0, replayMessage);
    }
  }
}
