import 'package:flutter/material.dart';
import 'dart:typed_data';

// 画像を表示するクラス
// 引数でUnit8List型のデータを受け取りそれを画像として返す
class CreateMediaList extends StatelessWidget {
  final List<Uint8List> images; // 複数の画像データを保持するリスト

  CreateMediaList({required this.images}); // コンストラクタで画像データのリストを受けとる

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length, // リスト内のアイテム数
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Image.memory(images[index]), // 画像データを表示
        );
      },
    );
  }
}
