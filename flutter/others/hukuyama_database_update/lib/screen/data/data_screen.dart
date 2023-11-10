import 'package:flutter/material.dart';
import '/utils/database_helper.dart';
import '/screen/data/maintag_graph_data.dart';

class DataScreenWidget extends StatelessWidget {

  @override
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
            ElevatedButton(
              child: Text("tag_insert"),
              onPressed:(){_insert();},
            ),
            ElevatedButton(
              child: Text("tag_name"),
              onPressed:(){queryAllRows_tagName();},
            ),
          ]
        )
      ),
    );
  }
}

final dbHelper = DatabaseHelper.instance;

void _insert() async {
  Map<String, dynamic> row = {
    DatabaseHelper.columnTagName:'料理',
    DatabaseHelper.columnTagColor:"Red",
    DatabaseHelper.columnTagRegisteredActionName:"夜ご飯"
  };
    final tagInsert = await dbHelper.insert_tag_table(row);
    print(tagInsert);
}
 

 
