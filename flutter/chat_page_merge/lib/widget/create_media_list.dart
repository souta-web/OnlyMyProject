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
          margin: EdgeInsets.all(10.0), // 枠のマージンを設定
          padding: EdgeInsets.all(10.0), // 枠のパディングを設定
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // 枠線の色
              width: 1.0, // 枠線の幅
            ),
            borderRadius: BorderRadius.circular(10.0), // 枠の角丸を設定
          ),
          child: Image.memory(images[index]), // 画像データを表示
        );
      },
    );
  }
}
