import 'database_helper.dart';

// アクション登録汎用クラス
class RegisterActionTable {
  final int? actionId;  // アクションID
  final String? actionTitle;  // アクションタイトル
  final String? actionState;  // 進行状態
  final String? actionNotes;  // 説明文
  final int? actionScore; // 充実度
  final int? startChatId; // 開始チャットID

  RegisterActionTable({
    this.actionId,
    this.actionTitle,
    this.actionState,
    this.actionNotes,
    this.actionScore,
    this.startChatId,
  });

  void registerActionTableFunc() async {
    // データベースに登録
    print("これからアクションテーブルに登録");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    // アクションテーブルのデータを照会するリスト
    final List<Map<String, dynamic>> actionRows = await dbHelper.queryAllRows_action_table();

    // 開始チャットIDを連番で登録できるように変数を定義
    late int startChatId = actionRows.isNotEmpty ? (actionRows.last['start_chat_id'] ?? 0) + 1 : 1;

    final Map<String, dynamic> actionRow = {
      DatabaseHelper.columnActionId: actionId, // アクションID
      DatabaseHelper.columnActionTitle: actionTitle,  // アクションタイトル
      DatabaseHelper.columnActionState: actionState, // 進行状態
      DatabaseHelper.columnActionNotes: actionNotes, // 説明文
      DatabaseHelper.columnActionScore: actionScore, // 充実度(1から5までの値で制限する)
      DatabaseHelper.columnStartChatId: startChatId,  // 開始チャットID
    };

    await dbHelper.insert_action_table(actionRow);

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows = await dbHelper.queryAllRows_action_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }

  /*
  次のような形で呼び出すことができる
    RegisterActionTable registerActionTable = RegisterActionTable( //インスタンス化、引数渡し
      actionName: 'ゲーム',
      actionStart: '10:00',
    );

    registerActionTable.registerActionTableFunc(); //実際にデータベース登録
  */
}
