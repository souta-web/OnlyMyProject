import 'database_helper.dart';

// アクションタイムテーブル登録汎用クラス
class RegisterActionTimeTable {
  final int? actionTimeId;
  final int? actionId;
  final String? actionJudgeTime;
  final int? actionYear;
  final int? actionMonth;
  final int? actionDay;
  final int? actionHours;
  final int? actionMinutes;
  final int? actionSeconds;
  final double? lessActionSeconds;

  RegisterActionTimeTable({
    this.actionTimeId,
    this.actionId,
    this.actionJudgeTime,
    this.actionYear,
    this.actionMonth,
    this.actionDay,
    this.actionHours,
    this.actionMinutes,
    this.actionSeconds,
    this.lessActionSeconds,
  });

  void registerActionTimeTableFunc() async {
    // データベースに登録
    print('これからアクションタイムテーブルに登録');
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    // アクションテーブルから有効なアクションIDを取得
    final List<Map<String, dynamic>> actionRows =
        await dbHelper.queryAllRows_action_table();
    if (actionRows.isEmpty) return;
    final int actionId = actionRows[1]['_action_id'];

    final Map<String, dynamic> actionTimeRow = {
      DatabaseHelper.columnActionTimeId: actionTimeId,
      DatabaseHelper.columnSetActionId: actionId,
      DatabaseHelper.columnActionJudgeTime: actionJudgeTime,
      DatabaseHelper.columnActionYear: actionYear,
      DatabaseHelper.columnActionMonth: actionMonth,
      DatabaseHelper.columnActionDay: actionDay,
      DatabaseHelper.columnActionHours: actionHours,
      DatabaseHelper.columnActionMinutes: actionMinutes,
      DatabaseHelper.columnActionSeconds: actionSeconds,
      DatabaseHelper.columnLessActionSeconds: lessActionSeconds,
    };

    await dbHelper.insert_action_time_table(actionTimeRow);

    // デバッグ用データ表示プログラム
    final List<Map<String, dynamic>> allRows = await dbHelper.queryAllRows_action_time_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}