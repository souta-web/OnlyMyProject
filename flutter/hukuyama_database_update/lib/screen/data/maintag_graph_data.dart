import '/utils/database_helper.dart';

class MaintagGraphData {
  final String? tagName;
  final String? tagTotalMinutes;
  final String? tagTotalTime;

  MaintagGraphData({
    this.tagName,
    this.tagTotalMinutes,
    this.tagTotalTime
  });

  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  

  Future<List<MaintagGraphData>>
  fetchDataFromDatabase() async{
    final List<Map<String, dynamic>>
    dataMapList = await dbHelper.queryAllRows_tag_table();
    
      final List<MaintagGraphData> 
        dataList = dataMapList.map((dataMap) {
          return MaintagGraphData(
            DatabaseHelper.columnTagName: tagName,
          );
        }).toList();

    return dataList;
  }
}