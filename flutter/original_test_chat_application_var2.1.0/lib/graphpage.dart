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
}
