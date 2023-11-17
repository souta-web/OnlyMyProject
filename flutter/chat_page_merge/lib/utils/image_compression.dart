import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ImageCompression {
  // 画像を圧縮する関数
  // 引数で変換されたデータを受け取り、圧縮したデータを戻り値として返す
  List<Uint8List> compressImages(List<Uint8List> imageBytesList) {
    List<Uint8List> compressedImages = [];

    // 各画像を圧縮
    for (Uint8List imageBytes in imageBytesList) {
      Uint8List compressedImage = compressImage(imageBytes);
      compressedImages.add(compressedImage);
    }
    return compressedImages;
  }

  // 画像を圧縮する補助関数
  Uint8List compressImage(Uint8List imageBytes) {
    // 画像の解析
    img.Image image = img.decodeImage(imageBytes)!;

    // 圧縮処理
    img.Image compressedImage = img.copyResize(image,
        width: image.width ~/ 2, height: image.height ~/ 2);

    // 圧縮後の画像データをバイナリデータに変換
    Uint8List compressedBytes =
        Uint8List.fromList(img.encodePng(compressedImage));

    return compressedBytes;
  }
}
