import 'package:image_picker/image_picker.dart';
import 'register_media_table.dart';
import 'dart:typed_data';
import 'dart:io' as io;

// メディアを添付するクラス
class DrawMedia {
  final ImagePicker _imagePicker = ImagePicker(); // ImagePickerのインスタンス生成

  // 画像を選択してバイナリデータのリストを返す非同期メソッド
  Future<void> pickImages() async {
    final List<XFile>? pickedFiles =
        await _imagePicker.pickMultiImage(); // ユーザーに複数の画像を選択させる

    // ファイルが選択され、リストが空でない時の場合の処理
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (int i = 0; i < pickedFiles.length; i++) {
        final XFile file = pickedFiles[i];
        final Uint8List bytes =
            await io.File(file.path).readAsBytes(); // ファイルを読み込んでバイナリーデータに変換
        RegisterMediaTable registerMediaTable = RegisterMediaTable(
          media1: i == 0 ? Uint8List.fromList(bytes) : null,
          media2: i == 1 ? Uint8List.fromList(bytes) : null,
          media3: i == 2 ? Uint8List.fromList(bytes) : null,
          media4: i == 3 ? Uint8List.fromList(bytes) : null,
        );
        registerMediaTable.registerMediaTableFunc();
      }
    }
  }
}
