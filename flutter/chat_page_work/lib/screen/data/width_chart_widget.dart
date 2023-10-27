import 'package:flutter/material.dart';

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
      height: 400.0, // グラフの高さ
      padding: EdgeInsets.all(20.0),
      child: CustomPaint(
        size: Size(double.infinity, 400.0), // グラフのサイズ
        painter: HorizontalBarChartPainter(data), //バー描画のためのカスタムペインター
      ),
    );
  }
}

//詳細設定
class HorizontalBarChartPainter extends CustomPainter {
  final List<BarChartData> data;

  HorizontalBarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final double maxValue =
        data.map((item) => item.value).reduce((a, b) => a > b ? a : b);

    final double barWidth = size.width - 100; // 右側のバーの可変幅

    double y = 20.0; // グラフの最初の高さ

    for (final item in data) {
      //バーの長さ計算（value÷最大値×バーの横幅）
      final barLength = (item.value / maxValue) * barWidth;
      final barRect = Rect.fromPoints(
          Offset(100, y), Offset(100 + barLength, y + 30)); //バーの長さ計算、範囲設定
      final barPaint = Paint()..color = Colors.blue; // バーの色

      canvas.drawRect(barRect, barPaint);
      //バーの長方形を描画します。バーの位置とサイズが `barRect` に指定され、
      //描画スタイルは `barPaint` で設定されたものを使用します。

      // ラベルを描画
      final textPainter = TextPainter(
        text: TextSpan(
          text: item.label, //ラベル表示
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        textDirection: TextDirection.ltr, //テキストの方向左から右
      );
      textPainter.layout(maxWidth: barLength);
      textPainter.paint(canvas, Offset(90 - textPainter.width, y + 5));

      y += 40.0; // 次のバーの開始位置
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

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
      body: Column(
        children: [
          Text('Main Tags:'),
          HorizontalBarChart(data: mainTagData),
          Text('Actions:'),
          HorizontalBarChart(data: actionData),
        ],
      ),
    ),
  ));
}
