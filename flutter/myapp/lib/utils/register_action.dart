import 'debug_action.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

// actionをデータベースに登録する
class RegisterAction {
  // DebugActionクラスのインスタンス化
  final DebugAction debugAction = DebugAction();

  // トグルボタンの状態とテキストフィールドの入力内容を基に、
  // チャットテーブルとアクションテーブルにデータを登録する役割を担う
  Future<void> sendAction() async {
    final bool isAction =
        debugAction.toggleController.value; // トグルボタンの状態を示すbool値。オンの場合はtrue、オフの場合はfalseになる
    final String chatMessage = debugAction.chatPageTextFieldController.text;  // テキスト入力フィールド内容を制御するためのコントローラー

    // トグルボタンがオンかつテキストフィールドのにテキストが入力されている場合、
    // 関連する情報をデータベースに登録する
    if (isAction && chatMessage.isNotEmpty) {
      final String chatTime = DateTime.now().toString();  // 送信時刻
      final String chatChannel = "default"; // チャットチャンネル名を適宜設定

      // DatabaseHelperのインスタンス生成
      final Database? db = await DatabaseHelper.instance.database;

      // チャットテーブルに登録する際の各カラムに対するデータを含むマップ
      final Map<String, dynamic> chatRow = {
        DatabaseHelper.columnChatSender: 1, // 送信者情報: 1 (0=AI, 1=User)
        DatabaseHelper.columnChatTodo: 'true',
        DatabaseHelper.columnChatTodofinish: 0,
        DatabaseHelper.columnChatMessage: chatMessage,
        DatabaseHelper.columnChatTime: chatTime,
        DatabaseHelper.columnChatChannel: chatChannel,
      };

      // チャットテーブルに登録されたメッセージのID（プライマリーキー）
      // アクションテーブルのChatActionIdと紐づけるために使用される
      final int chatId = await db!.insert(DatabaseHelper.chat_table, chatRow);

      // アクションテーブルに登録する際の各カラムに対するデータを含むマップ
      // トグルボタンがオンの場合にのみ生成
      final Map<String, dynamic> actionRow = {
        DatabaseHelper.columnActionName: chatMessage, // アクション名
        DatabaseHelper.columnActionStart: chatTime, // 開始時刻
        DatabaseHelper.columnActionEnd: "10:00", // 終了時刻
        DatabaseHelper.columnActionDuration: "1:00", // 総時間
        DatabaseHelper.columnActionMessage: "アクションを開始しました", // 開始メッセージ
        DatabaseHelper.columnActionMedia: "テストメディア", // 添付メディア
        DatabaseHelper.columnActionNotes: "アクション中です", // 説明文
        DatabaseHelper.columnActionScore: 4, // 充実度(1から5までの値で制限する)
        DatabaseHelper.columnActionState: 0,  // 状態(0=未完了,1=完了)
        DatabaseHelper.columnActionPlace: "自宅", // 場所
        DatabaseHelper.columnActionMainTag: "趣味", // メインタグ
        DatabaseHelper.columnActionSubTag: "ゲーム", // サブタグ
        DatabaseHelper.columnChatActionId: chatId,  // このチャットと紐づけられているアクションのidがここに入る
      };

      await db.insert(DatabaseHelper.action_table, actionRow);
    }
  }
}
