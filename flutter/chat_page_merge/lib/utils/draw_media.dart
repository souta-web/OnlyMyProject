import 'package:image_picker/image_picker.dart';
import 'register_action_table.dart';
import '/widget/create_media_list.dart';
import 'dart:typed_data';
import 'dart:io' as io;

// メディアを添付するクラス
class DrawMedia {
  final ImagePicker _imagePicker = ImagePicker(); // ImagePickerのインスタンス生成

  // 画像を選択してバイナリデータのリストを返す非同期メソッド
  Future<void> pickImages(List<Uint8List> mediaList) async {
    final List<XFile>? _pickedFiles = await _imagePicker.pickMultiImage(); // ユーザーに複数の画像を選択させる

    // ファイルが選択され、リストが空でない時の場合の処理
    if (_pickedFiles != null && _pickedFiles.isNotEmpty) {
      mediaList.clear(); // 既存のmediaListをクリアする

      for (int i = 0; i < _pickedFiles.length; i++) {
        final XFile file = _pickedFiles[i];
        final Uint8List bytes =
            await io.File(file.path).readAsBytes(); // ファイルを読み込んでバイナリーデータに変換
        mediaList.add(bytes); // リストにバイナリデータを追加
      }
      RegisterActionTable registerActionTable =
          RegisterActionTable(actionMedia: mediaList); // リスト全体を設定

      registerActionTable.registerActionTableFunc();
      print('選択した画像の数: ${_pickedFiles.length}');
      print('追加された画像の数: ${mediaList.length}');
    }
  }

  // メディアを表示するウィジェット
  dynamic buildMediaList(List<Uint8List> mediaList) {
    if (mediaList.isNotEmpty) {
      CreateMediaList createMediaList = CreateMediaList(images: mediaList);
      return createMediaList;
    } else {
      return; // メディアがない場合は何もしない
    }
  }
}
