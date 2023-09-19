import 'package:image_picker/image_picker.dart';
import 'register_media_table.dart';
import 'dart:typed_data';
import 'dart:io' as io;

// メディアを添付するクラス
class DrawMedia {
  final ImagePicker _imagePicker = ImagePicker(); // ImagePickerのインスタンス生成

  // 画像を選択してバイナリデータのリストを返す非同期メソッド
  Future<List<Uint8List>> pickImages() async {
    final List<XFile>? pickedFiles =
        await _imagePicker.pickMultiImage(); // ユーザーに複数の画像を選択させる
    final List<Uint8List> imageList = []; // 選択された画像のバイナリーデータを格納するリスト

    // ファイルが選択され、リストが空でない時の場合の処理
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      print(pickedFiles);
      for (XFile file in pickedFiles) {
        final bytes =
            await io.File(file.path).readAsBytes(); // ファイルを読み込んでバイナリーデータに変換
        imageList.add(Uint8List.fromList(bytes)); // バイナリーデータをリストに追加
      }
    }
    // 画像が1枚以上選択されている場合にのみデータベースに登録
    if (imageList.isNotEmpty) {
      RegisterMediaTable registerMediaTable = RegisterMediaTable(
        media1: imageList.length > 0 ? imageList[0] : null,
        media2: imageList.length > 1 ? imageList[1] : null,
        media3: imageList.length > 2 ? imageList[2] : null,
        media4: imageList.length > 3 ? imageList[3] : null,
      );
      registerMediaTable.registerMediaTableFunc();
    }
    print(imageList);
    return imageList; // 選択された画像のバイナリーデータのリストを返す
  }
}
