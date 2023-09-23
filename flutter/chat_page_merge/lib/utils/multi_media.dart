import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class MultiMedia {
  // 画像を選択し、バイナリーデータに変換する関数
  Future<List<Uint8List>> pickAndConvertImages(
      List<Uint8List> imageBytesList) async {
    final ImagePicker picker = ImagePicker(); // ImagePickerのインスタンス生成

    try {
      final List<XFile>? pickedImages =
          await picker.pickMultiImage(); // 画像を複数選択できるようにする
      if (pickedImages != null) {
        // 選択された画像ごとに処理を行う
        for (var selectedImage in pickedImages) {
          // 選択された画像をバイナリーデータに変換する
          final Uint8List imageBytes = await selectedImage.readAsBytes();
          // バイナリーデータをリストに追加
          imageBytesList.add(Uint8List.fromList(imageBytes));
        }
        print('imageBytesList: $imageBytesList');
      }
    } catch (e) {
      print('画像の選択エラー: $e');
    }

    // 変換された画像データのリストを返す
    return imageBytesList;
  }
}
