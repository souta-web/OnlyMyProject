import 'package:flutter/material.dart';
import '/screen/data/calculate_graph_data.dart';


class BarChartData {
  final String label; //ラベル
  final double value; //値

  BarChartData(this.label, this.value);
}

//グラフの大枠
class HorizontalBarChart extends StatelessWidget {
  final List<BarChartData> data;

  HorizontalBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 400.0, // グラフの高さ
      padding: EdgeInsets.all(20.0),
      child: CustomPaint(
        size: Size(double.infinity, 400), // グラフのサイズ(2個目の高さ)
        //size: Size(double.infinity, 400)の400部分を定数化せずに計算式とかにしてやってみる
        painter: HorizontalBarChartPainter(data), //バー描画のためのカスタムペインター
      ),
    );
  }
}