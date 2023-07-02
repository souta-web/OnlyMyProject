import 'package:flutter/material.dart';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//デバッグモードバナーを非表示にする
      title: 'Piechart',
      theme: ThemeData(//アプリケーションのテーマカラーを決める
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(//appbarのある画面を作るという宣言
      appBar: AppBar(
        title: const Text('Piechart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
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
}