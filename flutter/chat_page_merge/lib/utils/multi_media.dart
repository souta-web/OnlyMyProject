import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

// メディアのデータを変換する
class MultiMedia {
  late List<XFile> _selectedImages = []; // 選択された画像のリスト

  // 画像を選択するための関数
  void pickImages() async {
    final ImagePicker picker = ImagePicker(); // ImagePickerのインスタンス生成
    try {
      final List<XFile>? pickedImages =
          await picker.pickMultiImage(); // 複数の画像を選択
      if (pickedImages != null) {
        _selectedImages = pickedImages; // 選択された画像をリストに追加
      }
    } catch (e) {
      print('画像の選択エラー: $e');
    }
  }

  // 画像をUint8List型のバイナリーデータに変換するための関数
  Future<List<Uint8List>> convertImagesToUint8List() async {
    List<Uint8List> imageBytesList = [];
    for (var selectedImage in _selectedImages) {
      final Uint8List imageBytes =
          await selectedImage.readAsBytes(); // ファイルを読み込んでバイナリーデータに変換
      imageBytesList.add(Uint8List.fromList(imageBytes)); // リストにバイナリデータを追加
    }
    return imageBytesList;
  }
}
