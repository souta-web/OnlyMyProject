import 'package:flutter/material.dart';
import 'dart:typed_data';

//画像を表示するクラス
//引数でUnit8List型のデータを受け取りそれを画像として返す
class DrawImage extends StatelessWidget {
  final Uint8List image;
  DrawImage({required this.image});

  @override
  Widget build(BuildContext context){
    return Container(
      child: Image.memory(image)
    );
  }
}