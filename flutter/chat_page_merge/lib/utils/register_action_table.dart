import 'database_helper.dart';

//動作未チェック

class RegisterActionTable{
  final String? actionName;
  final int? actionStart;

  RegisterActionTable ({this.actionName,
                    this.actionStart,
                    });

  void registerActionTableFunc() async {
    print("これからデータベース登録");
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnActionName : actionName,
      DatabaseHelper.columnActionStart : actionStart,
    };

    await dbHelper.insert_action_table(row);

    //↓デバッグ用のデータ表示プログラム
    final allRows = await dbHelper.queryAllRows_action_table();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
  }
}