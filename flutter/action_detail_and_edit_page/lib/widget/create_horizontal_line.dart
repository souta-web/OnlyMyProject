import 'package:flutter/material.dart';
class HorizontalLine extends StatelessWidget {
  final double _thisHeight = 1.5;
  @override
  build(BuildContext context) {
    return Divider(
      color: Colors.black, // 線の色を指定 (省略可能)
      height: _thisHeight, // 線の高さを指定 (省略可能)
      thickness: 1.5, // 線の太さを指定 (省略可能)
      indent: 0.0, // 線の開始位置からのオフセットを指定 (省略可能)
      endIndent: 0.0, // 線の終了位置からのオフセットを指定 (省略可能)
    );
  }
}