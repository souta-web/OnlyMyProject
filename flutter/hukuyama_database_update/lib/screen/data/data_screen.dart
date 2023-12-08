import 'package:flutter/material.dart';
import '/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '/utils/database_register.dart';

class DataScreenWidget extends StatefulWidget {
  @override
  _DataScreenWidget createState() => _DataScreenWidget();
}

class _DataScreenWidget extends State<DataScreenWidget> {
  @override
  void initState() {
    super.initState();
    query_insert(); // 初期化時にデータを取得
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
        automaticallyImplyLeading: false, // バックボタンを非表示にする
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/config');//routeに追加したconfigに遷移
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ElevatedButton(
            //   child: Text("tag_insert"),
            //   onPressed:(){_insert();},
            // ),
            ElevatedButton(
              child: Text("data_check"),
              onPressed:(){data_check();},
            ),
          ]
        )
      ),
    );
  }
}


final dbHelper = DatabaseHelper.instance;

void data_check() async {
  Database? db = await dbHelper.database;
  
  List<Map> result = await db!.rawQuery
  //追加したテーブルの確認
  ('SELECT * FROM tag_table');
  print(result);
}




// void _insert() async {
//   Map<String, dynamic> row = {
//     DatabaseHelper.columnTagName:"料理",
//     DatabaseHelper.columnTagColor:"Red",
//     DatabaseHelper.columnTagRegisteredActionName:"夜ご飯"
//   };
//     final tagInsert = await dbHelper.insert_tag_table(row);
//     print("登録");
// }
 

 
