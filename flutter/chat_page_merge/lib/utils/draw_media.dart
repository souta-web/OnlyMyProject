import 'package:image_picker/image_picker.dart';
import 'register_action_table.dart';
import '../widget/create_media_list.dart';
import 'dart:typed_data';
import 'dart:io' as io;

// メディアを添付するクラス
class DrawMedia {
  final ImagePicker _imagePicker = ImagePicker(); // ImagePickerのインスタンス生成

  // 画像を選択してバイナリデータのリストを返す非同期メソッド
  dynamic pickImages() async {
    final List<XFile>? pickedFiles =
        await _imagePicker.pickMultiImage(); // ユーザーに複数の画像を選択させる

    // ファイルが選択され、リストが空でない時の場合の処理
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      List<Uint8List> mediaList = []; // バイナリデータを格納するリスト

      for (int i = 0; i < pickedFiles.length; i++) {
        final XFile file = pickedFiles[i];
        final Uint8List bytes =
            await io.File(file.path).readAsBytes(); // ファイルを読み込んでバイナリーデータに変換
        mediaList.add(bytes); // リストにバイナリデータを追加
      }
      RegisterActionTable registerActionTable =
          RegisterActionTable(actionMedia: mediaList); // リスト全体を設定
          
      // List<Uint8List>をList<int>に変換
      List<int>? mediaBytes = [];
      if (registerActionTable.actionMedia != null) {
        mediaBytes = [];
        for (Uint8List media in registerActionTable.actionMedia!) {
          mediaBytes.addAll(media);
        }
      }
      registerActionTable.registerActionTableFunc();

      // 画像表示のクラスのインスタンス生成
      // 表示の仕方がよくわかりません
      CreateMediaList createMediaList = CreateMediaList(images: mediaList);
      return createMediaList;
    }
  }
}
