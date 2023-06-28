import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';
import 'actiondetailpage.dart';

class ActionListPage extends StatelessWidget {
  // DatabaseHelper クラスのインスタンス取得
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: _GetActionName(),  // 非同期処理を実行する関数を指定
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // データがまだ取得されていない場合の処理
            return CircularProgressIndicator();  // ローディングインジケータなどの表示
          } else if (snapshot.hasError) {
            // データの取得中にエラーが発生した場合の処理
            return Text('Error: ${snapshot.error}');
          } else {
            // データが正常に取得された場合の処理
            List<Map<String, dynamic>>? data = snapshot.data;
            print(data);
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                String item = data?[index]['action_name'];
                int item2 = data?[index]['_action_id'];
                return GestureDetector(
                  onTap: () {
                    // クリック時の処理を実装
                    print('Item clicked: $item');
                    _MoveActionDetailPageProcess(item2,context);
                  },
                  child:Column(// 各アイテムのウィジェットを返す
                    children: [
                      SizedBox(height: 5),
                      _ListCard(item,data?.length),
                      SizedBox(height: 5),
                    ],
                  ),
                );
              },
            );
          }
        },
    );
  }

  Widget _ListCard(String item,int? _index) {
  // YourListItemWidgetのビルドロジックを実装する
  // itemを使用してウィジェットを作成し、それを返す
  print(_index.toString());
  return Container(
    height: 50,
    color: Colors.amber[600],
    child: Center(child: Text(item.toString())), 
  );
}

  Future<List<Map<String, dynamic>>?> _GetActionName() async {
    Database? db = await DatabaseHelper.instance.database;//データベース取得
    final List<Map<String, dynamic>>? action_table_name = await db?.query(
      'action_table',
      columns: ['_action_id','action_name'], // 取得したいカラムのリスト
    );
    return action_table_name;
  }

  void _MoveActionDetailPageProcess(int action_id,BuildContext context) async {
    Database? db = await DatabaseHelper.instance.database;//データベース取得
    final List<Map<String, dynamic>>? result = await db?.query(
      'action_table', // テーブル名
      where: '_action_id = ?', // 条件式
      whereArgs: [action_id], // 条件の値
    );
    print(result);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ActionDetailPage(action_table_alldata_detailpage:result?[0])),
    );
    
  }
}