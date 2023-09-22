import 'package:flutter/material.dart';
import 'dart:typed_data';

// 複数の画像を表示するクラス
// 引数でList<Uint8List>型のデータを受け取りそれを画像として返す
class CreateImages extends StatelessWidget {
  final List<Uint8List> images;
  CreateImages({required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: images.map((imageData) {
        return Container(
          margin: const EdgeInsets.all(10.0), // 画像間の余白を調整
          decoration: BoxDecoration ( 
            border: Border.all(
            color: Colors.orange, // 枠の色を設定
            width: 2.0, // 枠の太さを設定
            ),
            borderRadius: BorderRadius.circular(8.0), // 枠の角丸を設定
          ),
          child: Image.memory(imageData),
        );
      }).toList(),
    );
  }
}
