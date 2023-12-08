import '/utils/database_helper.dart';

class MaintagGraphData {
  final String? columnTagName;
  //final String? tagTotalMinutes;
  //final String? tagTotalTime;

  MaintagGraphData({
    this.columnTagName,
    //this.tagTotalMinutes,
    //this.tagTotalTime
  });

  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  

  Future<List<MaintagGraphData>>
  fetchDataFromDatabase() async{
    final List<Map<String, dynamic>>
    dataMapList = await dbHelper.queryAllRows_tag_table();

    final List<MaintagGraphData> 
      dataList = dataMapList.map((dataMap) {
        return MaintagGraphData(
          columnTagName: dataMap[DatabaseHelper.columnTagName],
        );
      }).toList();

    return dataList;
  }
}





//List<Map> result2 = await db!.rawQuery
// ('SELECT action_name FROM action_table WHERE _action_id < 5');
// print(result2);

// List<Map> result = [...result1, ...result2];
//   print(result);



// バックからフロントに渡すデータの型
// メインタグ別のデータList<Map<String,String>>
// [{TagName:メインタグ名,TagTotalMinutes:そのタグの総時間(分変換),
// TagTotalTime:そのタグの総時間(XX時間YY分)},・・・同じ型の辞書型がメインタグ数だけ入る]
// アクション別のデータList<Map<String,String>>
// [{ActionName:アクション名,ActionTotalMinutes:そのアクションの総時間(分変換),
// ActionTotalTime:そのアクションの総時間(XX時間YY分),ThisActionTag:このアクションのに紐づけられているメインタグ名}
// ・・・選択されている範囲内のアクション数分だけ入る]