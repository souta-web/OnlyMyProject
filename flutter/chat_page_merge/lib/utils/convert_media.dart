import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

// 画像をバイナリーデータに変換するクラス
class ConvertMedia {
  // 画像を選択し、バイナリーデータに変換する関数
  // 引数でバイナリデータを格納するリストを受け取る
  // 選択された画像のバイナリデータを含むリストを返す
  Future<List<Uint8List>> pickAndConvertImages(
      List<Uint8List> imageBytesList) async {
    final ImagePicker picker = ImagePicker(); // ImagePickerのインスタンス生成

    // 画像を選択
    final List<XFile?> pickedFiles = await picker.pickMultiImage();

    // 選択された画像の制限を4枚に設定
    if (pickedFiles.length > 4) {
      // リストから5枚目以降の画像を削除する
      pickedFiles.removeRange(4, pickedFiles.length);
      print('選択できる画像は4枚です');
    }

    // 選択された画像をバイナリーデータに変換する
    for (XFile? pickedFile in pickedFiles) {
      if (pickedFile != null) {
        // 画像データをバイナリーデータに変換し、リストに追加
        final Uint8List imageBytes = await pickedFile.readAsBytes();
        imageBytesList.add(imageBytes);
      }
    }

    // 変換されたバイナリデータを含むリストを返す
    return imageBytesList;
  }
}
