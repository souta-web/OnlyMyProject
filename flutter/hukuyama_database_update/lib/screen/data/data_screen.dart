import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataScreenWidget extends StatelessWidget {

  // 棒グラフの棒の横幅
  static double barWidth = 20.0;
  // グラフタイトルのラベル書式
  final TextStyle labelStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);

  // ダミーデータ
  final timedate = <double>[30, 25, 20, 15, 10];

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
        
      ),
    );
  }
}

 

 
