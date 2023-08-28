import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:io' as io;

/*
  getMediaを使うときは呼び出し元クラス内で次の三行をコピペして、
  [変数名=_getMedia()]でメディア取得をする
  Future<Uint8List?> _getMedia() async {
    return await MediaController.getMedia();
  }
*/

class MediaController {
  //メディア追加ボタン押された時の処理
  static Future<Uint8List?> getMedia() async {
    //late var _file_path; //ユーザーがファイルを送信するときにここにそのディレクトリが入る
    late Uint8List? mediaData = null;
    final result = await FilePicker.platform.pickFiles();//選択されたファイルを取得する
    if (result != null) {
      // ファイルが選択された場合の処理
      // 選択されたファイルにアクセスするための情報は`result`オブジェクトに含まれます
      // 例えば、`result.files.single.path`でファイルのパスにアクセスできます
      final path = result.files.single.path;
      if (path != null) {
        // ファイルにアクセスして適切な処理を行います
        final bytes = await io.File(path).readAsBytes();
        mediaData = Uint8List?.fromList(bytes);
      }
    } else {
      // キャンセルされた場合の処理
    }
    //画像データを返す
    return mediaData;
  }
  
  Uint8List? _nullCheckMedia(var _media) {
    if (_media != null){
      return _media;
    } else {
      return null;
    }
  }
}