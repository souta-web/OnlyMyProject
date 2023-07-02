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

class GraphPage extends StatefulWidget {
  @override
  _GraphPage createState() => _GraphPage();
}

class _GraphPage extends State<GraphPage> {
  late List<charts.Series> seriesList;
  late bool animate;

  PieChartExample(this.seriesList, {required this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.ArcRendererConfig(
        arcRendererDecorators: [charts.ArcLabelDecorator()],
      ),
    );
  }
}

List<charts.Series<Task, String>> _createSampleData() {
  final data = [
    Task('Task 1', 35.0),
    Task('Task 2', 25.0),
    Task('Task 3', 20.0),
    Task('Task 4', 10.0),
    Task('Task 5', 10.0),
  ];

  return [
    charts.Series<Task, String>(
      id: 'Tasks',
      domainFn: (Task task, _) => task.task,
      measureFn: (Task task, _) => task.taskValue,
      data: data,
      labelAccessorFn: (Task row, _) => '${row.taskValue}%',
    )
  ];
}

class Task {
  final String task;
  final double taskValue;

  Task(this.task, this.taskValue);
}