import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math' as math;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chatpage.dart';
import 'actionlistpage.dart';
import 'actiondetailpage.dart';
import 'actioneditpage.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphPage extends StatefulWidget {
  @override
  _GraphPage createState() => _GraphPage();
}

class _GraphPage extends State<GraphPage> {
  List<Map<String, dynamic>> _tags_amount = []; //グラフ用のデータ入れる
  

  @override
  void initState() {
    super.initState();
    _getTagAmount();

  }
  @override
  Widget build(BuildContext context) {
    return Container(//appbarのある画面を作るという宣言
      child: Padding(//余白のあるウィジェットを作成
        padding: const EdgeInsets.all(30),//余白のサイズ
        child: PieChart(PieChartData(
          centerSpaceRadius: 5,
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
          sections: [
            PieChartSectionData(value: 35, color: Colors.purple, radius: 100),
            PieChartSectionData(value: 40, color: Colors.amber, radius: 100),
            PieChartSectionData(value: 55, color: Colors.green, radius: 100),
            PieChartSectionData(value: 70, color: Colors.orange, radius: 100),
          ])
        )
      ),
    );
  }

  void _getTagAmount() async {//登録されているタグを取得してそれぞれのタグが何個登録されているかを調べる
    Database? db = await DatabaseHelper.instance.database;//データベース取得
    List<Map<String, dynamic>> result = [];
    if (db != null) {
      result = await db.query('action_table');
    }
    for (var row in result){
      List<Map<String, dynamic>> _tags_amount_tmp = _tags_amount.toList(); //for文の中でリストに変更を加えることができないため一時的なリストとして使用
      final _main_tag_name = row['action_main_tag'];
      if (_tags_amount_tmp.length != 0) {//
        _tags_amount.asMap().forEach((index,tag_inf) {//_tags_amountの要素を１つずつ代入する
          if (_main_tag_name == tag_inf['tag_name']){//もしもすでに_tag_amountに_main_tag_nameと同じタグが登録されていたら
            _getTagAmount_relation(index);//tag_amountのカウントを増やす
          }else{//登録されていなかったら
            final _tmp = {'tag_name':_main_tag_name,'tag_amount':1};
            _getTagAmount_relation(_tmp);
          }
        });
      } else {
        final _tmp = {'tag_name':_main_tag_name,'tag_amount':1};
        _getTagAmount_relation(_tmp);
      }
    }
    print(_tags_amount);
  }

  void _getTagAmount_relation(var _data) {
    if (_data is Map<String, dynamic>) {
      _tags_amount.add(_data);
      print('_getTagAmount_relationがtrue');
    }else{
      _tags_amount[_data]['tag_amount']++;
      print('_getTagAmount_relationがfalse');
    };
  }
}
