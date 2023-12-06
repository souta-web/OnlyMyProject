import 'package:flutter/material.dart';
import 'package:nosato_chat_page_work/screen/data/2width_chart_widget.dart';

class BarChartData {
  final String label; //ラベル
  final double value; //値

  BarChartData(this.label, this.value);
}

//グラフの大枠
class HorizontalBarChart extends StatelessWidget {
  final List<BarChartData> data;

  HorizontalBarChart({required this.data});

  double dataHeight(BuildContext context) {
    //画面の高さに基づいて動的に計算
    double screenHeight = MediaQuery.of(context).size.height; //画面の高さを取得
    return screenHeight * 0.6; //画面の高さの60%
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: CustomPaint(
        size: Size(double.infinity, dataHeight(context)), // グラフのサイズ(2個目の高さ)
        //size: Size(double.infinity, 400)の400部分を定数化せずに計算式とかにしてやってみる
        painter: HorizontalBarChartPainter(data), //バー描画のためのカスタムペインター
      ),
    );
  }
}

//表に出す部分と裏の部分でなるべく分けたい

/*
void main() {
  final List<BarChartData> mainTagData = [
    BarChartData('MainTag1', 120),
    BarChartData('MainTag2', 90),
    // 他のメインタグのデータも同様に追加
  ];

  final List<BarChartData> actionData = [
    BarChartData('Action1', 60),
    BarChartData('Action2', 45),
    // 他のアクションのデータも同様に追加
  ];

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Custom Horizontal Bar Chart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Main Tags:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            HorizontalBarChart(data: mainTagData),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Actions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            HorizontalBarChart(data: actionData),
          ],
        ),
      ),
    ),
  ));
}*/
