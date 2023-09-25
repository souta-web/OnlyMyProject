import 'package:flutter/material.dart';
import 'dart:typed_data';

// 複数の画像を表示するクラス
// 引数でList<Uint8List>型のデータを受け取りそれを画像として返す
class CreateImages extends StatelessWidget {
  final String text;
  final List<Uint8List> images;

  CreateImages({
    required this.text, 
    required this.images,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width / 2, // 画面の右半分に制限
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 149, 21),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // テキストを左寄せに配置
          children: <Widget>[
            Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0), // テキストと画像の間隔を設定
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2列に表示
                  crossAxisSpacing: 10.0, // 画像間の水平間隔
                  mainAxisSpacing: 10.0, // 画像間の垂直間隔
                ),
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.memory(
                    images[index],
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
