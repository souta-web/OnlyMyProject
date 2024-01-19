import 'package:flutter/material.dart';
import 'dart:typed_data';

class CreateImages extends StatelessWidget {
  final String text;
  final List<Uint8List> images;
  final String? time;

  CreateImages({
    required this.text,
    required this.images,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _createTimeWidget(time),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 149, 21), // オレンジの背景色
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 5),
                images.length == 1
                ? _createSingleImage(images[0])
                : _createImageGrid(images),
              ],
            )
          ),
        ),
        const SizedBox(width: 10),  // 右側の隙間
      ],
    );
  }

  Widget _createTimeWidget(String? _time) {
    // null許容のString?型を、nullの場合にデフォルト値を表示するように修正
    final timeToDisplay = _time ?? "No time provided";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      alignment: Alignment.bottomCenter,
      child: Text(
        timeToDisplay,
        style: TextStyle(fontSize: 12.0, color: Colors.grey),
      ),
    );
  }

  Widget _createSingleImage(Uint8List image) {
    return Container(
      width: 100, // 画像が1枚の場合の幅
      height: 100, // 画像が1枚の場合の高さ
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: MemoryImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _createImageGrid(List<Uint8List> images) {
    return Wrap(
      spacing: 5.0, // 画像同士の横のスペース
      runSpacing: 5.0, // 画像同士の縦のスペース
      children: images.map((image) => _createSingleImage(image)).toList(),
    );
  }
}
