import 'package:flutter/material.dart';
import '/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '/utils/database_register.dart';

class DataScreenWidget extends StatefulWidget {
  @override
  _DataScreenWidget createState() => _DataScreenWidget();
}

class _DataScreenWidget extends State<DataScreenWidget> {
  TextEditingController _controller = TextEditingController();
  List<String> _exquery = ['SELECT * FROM tag_table', 'SELECT * FROM tag_table WHERE tag_name = "遊び"',
   'SELECT tag_name FROM tag_table WHERE tag_name = "ゲーム" OR tag_name = "睡眠"',
   'SELECT * FROM (SELECT * FROM tag_table LEFT JOIN action_table ON tag_table._tag_id = action_table._action_id) AS A GROUP BY _tag_id HAVING _tag_id % 2 = 0'];

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 8,
              // onChanged: (value) {
              //   // 予測変換のリストを更新
              //   setState(() {
              //     _exquery = _getExquery(value);
              //   });
              // },
              onTap: () {
                showexquerys();
              },
              decoration: InputDecoration(
                hintText: "query",
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text("Run",
              style: (TextStyle(color: Colors.white,))
            )
            
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount: _exquery.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_exquery[index]),
                  onTap: () {
                    // 選択された項目をTextFieldに反映
                    setState(() {
                      _controller.text = _exquery[index];
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // List<String> _getExquery(String query) {
  // // 入力に基づいて予測変換のリストを生成
  // return _exquery
  //     .where((item) => item.toLowerCase().contains(query.toLowerCase()))
  //     .toList();
  // }

  void showexquerys() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exquerys'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _exquery.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_exquery[index]),
                  onTap: () {
                    // 選択されたアイテムをテキストフィールドにセット
                    _controller.text = _exquery[index];
                    Navigator.pop(context); // ダイアログを閉じる
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}








// final dbHelper = DatabaseHelper.instance;

// void data_check() async {
//   Database? db = await dbHelper.database;
  
//   List<Map> result = await db!.rawQuery
//   //追加したテーブルの確認
//   ('SELECT * FROM tag_table');
//   print(result);
// }


// void _insert() async {
//   Map<String, dynamic> row = {
//     DatabaseHelper.columnTagName:"料理",
//     DatabaseHelper.columnTagColor:"Red",
//     DatabaseHelper.columnTagRegisteredActionName:"夜ご飯"
//   };
//     final tagInsert = await dbHelper.insert_tag_table(row);
//     print("登録");
// }


            // ElevatedButton(
            //   child: Text("tag_insert"),
            //   onPressed:(){_insert();},
            // ),
            // ElevatedButton(
            //   child: Text("data_check"),
            //   onPressed:(){data_check();},
            //),

 
