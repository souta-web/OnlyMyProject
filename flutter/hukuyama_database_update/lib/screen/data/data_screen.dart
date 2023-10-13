import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
        child: BarChart(
            //vertical: false,
          BarChartData(
            // 棒グラフの位置
            alignment: BarChartAlignment.spaceEvenly,
            
            // グリッド線を非表示にする
            gridData: FlGridData(
              show: false, 
            ),
            // 枠線を非表示にする
            borderData: FlBorderData(
              show: false,
            ),
            /* 左右のラベルを非表示にする
            titlesData: FlTitlesData(
              leftTitles: SideTitles(show: false),
              rightTitles: SideTitles(show: false),
            ),*/

            barGroups: [
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(toY: timedate[0], width: barWidth, color: Colors.blue),
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(toY: timedate[1], width: barWidth, color: Colors.pink),
              ]),
              BarChartGroupData(x: 4, barRods: [
                BarChartRodData(toY: timedate[2], width: barWidth, color: Colors.orange),
              ]),
              BarChartGroupData(x: 5, barRods: [
                BarChartRodData(toY: timedate[3], width: barWidth, color: Colors.green),
              ]),
              BarChartGroupData(x: 6, barRods: [
                BarChartRodData(toY: timedate[4], width: barWidth, color: Colors.grey),
              ]),
            ]
          ),
        ),
      ),
    );
  }
}