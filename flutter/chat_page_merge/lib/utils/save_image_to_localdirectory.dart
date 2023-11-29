import 'dart:io';
import 'dart:typed_data';

// 画像をローカルディレクトリに保存するクラス
class SaveImageToLocalDirectory {
  // 画像をローカルディレクトリに保存する関数
  // 引数でバイナリデータを含むリストを受け取り、保存された画像のパスを返す
  Future<List<String>> saveImages(List<Uint8List> imageBytesList) async {
    // 保存されたパスを格納するリスト
    List<String> savedImagePaths = [];

    // ローカルディレクトリのパスを設定
    String directoryPath = '/path/to/your/local/directory/';

    // ディレクトリが存在しない場合は作成
    Directory directory = Directory(directoryPath);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    // 画像を保存
    for (int i = 0; i < imageBytesList.length; i++) {
      Uint8List imageBytes = imageBytesList[i];
      String imagePath = '$directoryPath/image_$i.png';

      // 画像データをファイルに書き込む
      await File(imagePath).writeAsBytes(imageBytes);

      // 保存された画像のパスをリストに追加
      savedImagePaths.add(imagePath);
    }

    // 保存された画像のパスを含むリストを返す
    return savedImagePaths;
  }
}
