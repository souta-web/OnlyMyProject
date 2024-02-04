import 'package:flutter/material.dart';
import '/screen/data/width_chart_widget.dart';

//詳細設定
class HorizontalBarChartPainter extends CustomPainter {
  final List<BarChartData> data;

  HorizontalBarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    //ダミーデータ内の各バーの値（`item.value`）から最大値を見つけます
    final double maxValue =
        data.map((item) => item.value).reduce((a, b) => a > b ? a : b);

    final double barWidth = size.width - 100; // 右側のバーの可変幅

    double y = 20.0; // グラフの最初の高さ

    for (final item in data) {
      //for文のところを関数化する
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
