import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timeline Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimelineScreen(),
    );
  }
}

class TimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timeline'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(200, 800), // カスタム描画領域のサイズ
          painter: TimelinePainter(), // カスタムペインターを指定
        ),
      ),
    );
  }
}

class TimelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    // タイムラインの時間と縦線を描画
    for (int hour = 1; hour <= 24; hour++) {
      final y = (hour / 12) * size.height;
      final double startX = 0;
      final endX = size.width;
      canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: hour.toString(),
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(
        minWidth: size.width, // テキストの位置を調整
        maxWidth: size.width,
      );

      textPainter.paint(canvas, Offset(endX + 5, y - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
