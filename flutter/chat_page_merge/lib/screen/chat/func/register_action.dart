import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '/utils/database_helper.dart';
import '/widget/chat_todo.dart';
import '/screen/chat/func/register_text.dart';

// actionをデータベースに登録する
class RegisterAction {
  // トグルボタンの状態とテキストフィールドの入力内容を基に、
  // チャットテーブルとアクションテーブルにデータを登録する役割を担う
  static Future<void> sendAction(String chatText, List<dynamic> messages,
      TextEditingController controller) async {
    RegisterText.handLeSubmitted(chatText, messages, controller);
    String startTime = DateTime.now().toString(); // 送信時間
    // アクションを作成する
    ChatTodo actionMessage = ChatTodo(
        title: chatText,
        isSentByUser: false,
        mainTag: "#趣味",
        startTime: startTime,
        actionFinished: false);

    controller.clear();
    messages.add(actionMessage);

    // トグルボタンがオンかつテキストフィールドにテキストが入力されている場合、
    // 関連する情報をデータベースに登録する
    if (chatText.isNotEmpty) {
      // DatabaseHelperのインスタンス生成
      final Database? db = await DatabaseHelper.instance.database;

      // チャットテーブルに登録する際の各カラムに対するデータを含むマップ
      final Map<String, dynamic> chatRow = {
        DatabaseHelper.columnChatSender: 1, // 送信者情報: 1 (0=AI, 1=User)
        DatabaseHelper.columnChatTodo:
            'true', // todoかどうか(true=todo:false=message)
        DatabaseHelper.columnChatTodofinish: 0,
        DatabaseHelper.columnChatMessage: chatText, // チャットのテキスト
        DatabaseHelper.columnChatTime: startTime, // 送信時間
        DatabaseHelper.columnChatChannel: "aaaa", // チャットチャンネル
      };

      // チャットテーブルに登録されたメッセージのID（プライマリーキー）
      // アクションテーブルのChatActionIdと紐づけるために使用される
      final int chatActionId =
          await db!.insert(DatabaseHelper.chat_table, chatRow);
      // アクションテーブルに登録する際の各カラムに対するデータを含むマップ
      // トグルボタンがオンの場合にのみ生成
      final Map<String, dynamic> actionRow = {
        DatabaseHelper.columnActionName: chatText, // アクション名
        DatabaseHelper.columnActionStart: startTime, // 開始時刻
        DatabaseHelper.columnActionEnd: "10:00", // 終了時刻
        DatabaseHelper.columnActionDuration: "1:00", // 総時間
        DatabaseHelper.columnActionMessage: "アクションを開始しました", // 開始メッセージ
        DatabaseHelper.columnActionMedia: "テストメディア", // 添付メディア
        DatabaseHelper.columnActionNotes: "アクション中です", // 説明文
        DatabaseHelper.columnActionScore: 4, // 充実度(1から5までの値で制限する)
        DatabaseHelper.columnActionState: 0, // 状態(0=未完了,1=完了)
        DatabaseHelper.columnActionPlace: "自宅", // 場所
        DatabaseHelper.columnActionMainTag: actionMessage.mainTag, // メインタグ
        DatabaseHelper.columnActionSubTag: "ゲーム", // サブタグ
        DatabaseHelper.columnActionId:
            chatActionId, // このチャットと紐づけられているアクションのidがここに入る
      };

      // アクションテーブルにデータを登録
      await db.insert(DatabaseHelper.action_table, actionRow);
    }
  }

  // データ確認用メソッド
  static Future<void> confirmChatActionData() async {
    // データ確認や表示ロジックをここに記述
    final dbHelper = DatabaseHelper.instance;
    final List<Map<String, dynamic>> chats =
        await dbHelper.queryAllRows_chat_table();

    final List<Map<String, dynamic>> actions =
        await dbHelper.queryAllRows_action_table();

    print("チャットテーブルのデータ:");
    chats.forEach((chat) {
      print(
          "ID: ${chat[DatabaseHelper.columnChatId]}, Sender: ${chat[DatabaseHelper.columnChatSender]}, Todo: ${chat[DatabaseHelper.columnChatTodo]}, TodoFinish: ${chat[DatabaseHelper.columnChatTodofinish]}, Text: ${chat[DatabaseHelper.columnChatMessage]}, Time: ${chat[DatabaseHelper.columnChatTime]}, ChatChannel: ${chat[DatabaseHelper.columnChatChannel]}, ChatActionId: ${chat[DatabaseHelper.columnChatActionId]},");
    });
    print("---------------------------");
    print("アクションテーブルのデータ:");
    actions.forEach((action) {
      print(
          "ActionName: ${action[DatabaseHelper.columnActionName]}, Start: ${action[DatabaseHelper.columnActionStart]}, End: ${action[DatabaseHelper.columnActionEnd]}, Duration ${action[DatabaseHelper.columnActionDuration]}, Message: ${action[DatabaseHelper.columnActionMessage]}, Notes: ${action[DatabaseHelper.columnActionNotes]}, Score: ${action[DatabaseHelper.columnActionScore]}, State: ${action[DatabaseHelper.columnActionState]}, Place: ${action[DatabaseHelper.columnActionPlace]}, MainTag: ${action[DatabaseHelper.columnActionMainTag]}, SubTag: ${action[DatabaseHelper.columnActionSubTag]}, ChatActionId: ${action[DatabaseHelper.columnChatActionId]}");
    });
  }
}
