import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dynamic Line Chart'),
        ),
        body: LineChartWidget(),
      ),
    );
  }
}

class LineChartWidget extends StatefulWidget {
  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<LineChartBarData> lineData = []; // 折れ線グラフのデフォルトデータ
  String selectedOption = '遊び'; // 初期選択オプション

  @override
  void initState() {
    super.initState();
    // アプリ起動時に初期データを設定
    updateData();
  }

  // ダミーデータ生成
  List<LineChartBarData> generateDefaultLineData() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(0, 5),
          FlSpot(1, 8),
          FlSpot(2, 9),
          FlSpot(3, 2),
          FlSpot(4, 7),
          FlSpot(5, 20),
          FlSpot(6, 10),
          FlSpot(7, 7),
        ],
        isCurved: false,
        colors: [Colors.blue],
        barWidth: 2,
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  // オプションごとのデータ
  Map<String, List<LineChartBarData>> optionData = {
    '遊び': generatePlayLineData(),
    '食事': generateMealLineData(),
    '睡眠': generateSleepLineData(),
    '生活': generateLifeLineData(),
    '勉強': generateStudyLineData(),
  };

  // 各オプションに応じたダミーデータ生成 //遊び
  static List<LineChartBarData> generatePlayLineData() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(0, 4),
          FlSpot(1, 6),
          FlSpot(2, 7),
          FlSpot(3, 5),
          FlSpot(4, 9),
          FlSpot(5, 3),
          FlSpot(6, 8),
          FlSpot(7, 7),
        ],
        isCurved: false,
        colors: [Colors.green],
        barWidth: 2,
        belowBarData: BarAreaData(show: false),
      ),
      LineChartBarData(
        spots: [
          FlSpot(0, 1), // データポイント (日にち,時間)
          FlSpot(1, 3),
          FlSpot(2, 2),
          FlSpot(3, 4),
          FlSpot(4, 1),
          FlSpot(5, 0),
          FlSpot(6, 18),
          FlSpot(7, 7),
        ],
        isCurved: false, // 滑らかな線にする
        colors: [Colors.red], //線の色
        barWidth: 2, //線の太さ
        belowBarData: BarAreaData(show: true), //影的なの
      ),
    ];
  }

  //食事
  static List<LineChartBarData> generateMealLineData() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(0, 3),
          FlSpot(1, 5),
          FlSpot(2, 4),
          FlSpot(3, 6),
          FlSpot(4, 5),
          FlSpot(5, 3),
          FlSpot(6, 4),
          FlSpot(7, 6),
        ],
        isCurved: false,
        colors: [Colors.orange],
        barWidth: 2,
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  //睡眠
  static List<LineChartBarData> generateSleepLineData() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(0, 8),
          FlSpot(1, 9),
          FlSpot(2, 10),
          FlSpot(3, 7),
          FlSpot(4, 9),
          FlSpot(5, 8),
          FlSpot(6, 9),
          FlSpot(7, 7),
        ],
        isCurved: false,
        colors: [Colors.purple],
        barWidth: 2,
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  //生活
  static List<LineChartBarData> generateLifeLineData() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(0, 7),
          FlSpot(1, 6),
          FlSpot(2, 8),
          FlSpot(3, 7),
          FlSpot(4, 7),
          FlSpot(5, 6),
          FlSpot(6, 8),
          FlSpot(7, 9),
        ],
        isCurved: false,
        colors: [Colors.yellow],
        barWidth: 2,
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  //勉強
  static List<LineChartBarData> generateStudyLineData() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(0, 2),
          FlSpot(1, 4),
          FlSpot(2, 6),
          FlSpot(3, 5),
          FlSpot(4, 3),
          FlSpot(5, 4),
          FlSpot(6, 3),
          FlSpot(7, 5),
        ],
        isCurved: false,
        colors: [Colors.red],
        barWidth: 2,
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  void updateData() {
    setState(() {
      // 選択されたオプションに応じたデータを取得
      lineData = optionData[selectedOption]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //プルダウン選択
        DropdownButton<String>(
          value: selectedOption,
          items: <String>['遊び', '食事', '睡眠', '生活', '勉強']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedOption = newValue!;
              //選択された値がnewvalueに格納
              // グラフのデータを更新するロジックをここに追加
              updateData();
            });
          },
        ),
        Container(
          height: 200, //グラフの高さを調整
          padding: EdgeInsets.all(20), //グラフ全体を上下左右にずらす
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true), //グリッド線
              titlesData: FlTitlesData(
                //目盛り
                leftTitles: SideTitles(
                  showTitles: true, //左側表示
                  getTitles: (value) {
                    //コールバック
                    return value.toStringAsFixed(0); //数値を整数にフォーマットして表示
                  },
                ),
                rightTitles: SideTitles(showTitles: false), //右側非表示
                topTitles: SideTitles(showTitles: false), //上側非表示
                bottomTitles: SideTitles(
                    showTitles: true, //下側表示
                    getTitles: (value) {
                      if (value == 0) return 'Day1';
                      if (value == 1) return 'Day2';
                      if (value == 2) return 'Day3';
                      if (value == 3) return 'Day4';
                      if (value == 4) return 'Day5';
                      if (value == 5) return 'Day6';
                      if (value == 6) return 'Day7';
                      return '';
                    }),
              ),
              borderData: FlBorderData(
                //枠線
                show: true, //枠線あり
                border: Border.all(
                  color: const Color(0xff37434d),
                  width: 1, //線の太さ
                ),
              ),
              minX: 0,
              maxX: 7,
              minY: 0,
              maxY: 24,
              lineBarsData: lineData, // オプションに応じたデータ
            ),
          ),
        ),
      ],
    );
  }
}
